import configparser
import expenses_pb2
import expenses_pb2_grpc
import grpc
import logging

from bson.objectid import ObjectId
from concurrent import futures
from os import path
from pymongo import MongoClient
from token_handler import verify_id_token

# Load configuration values
CONFIGFILE = 'configuration/config.ini'

config = configparser.ConfigParser()
if path.isfile(CONFIGFILE):
    config.read(CONFIGFILE)
else:
    # Load example usage as a default if
    # there is no configuration file present.
    config.read_dict({
        'mongodb': {
            'hostname': 'db',
            'port': 27017,
            'db': 'grpc_db',
            'collection': 'expenses',
        },
        'server': {
            'port': 50051,
        },
    })
    with open(CONFIGFILE, 'w') as configfile:
        config.write(configfile)


# Create database client
mongoConfig = config['mongodb']
client = MongoClient(
    f"mongodb://{mongoConfig['hostname']}:{mongoConfig['port']}/")
db = client[f"{mongoConfig['db']}"][f"{mongoConfig['collection']}"]


# Define helper functions to interact with database
def from_mongo(e):
    return expenses_pb2.Expense(
        winkelID=e['winkelID'],
        price=e['price'],
        timestamp=e['timestamp'],
        summary=e['summary'],
        expenseID=str(e['_id']),
        userID=str(e['userID'])
    )


def to_mongo(expense, id_set=False):
    dic = {
        'winkelID': expense.winkelID,
        'price': expense.price,
        'timestamp': expense.timestamp,
        'userID': expense.userID,
    }

    optional_fields = [('summary', '')]
    for field, default_value in optional_fields:
        dic[field] = (
            getattr(expense, field) if hasattr(expense, field)
            else default_value)

    if id_set:
        dic['expenseID'] = ObjectId(expense.expenseID)
    return dic


# Define helper functions to interact with request context
def getAuthenticationTokenFromContext(context):
    for key, value in context.invocation_metadata():
        if key.lower() == 'authentication':
            # trim off header prefix
            prefixLength = len("Bearer ")
            return value[prefixLength:]


def getUserIdFromAuthenticationToken(token):
    userInformation = verify_id_token(token)
    if userInformation is not None:
        return userInformation['user_id']


def getUserIdFromContext(context):
    token = getAuthenticationTokenFromContext(context)
    return getUserIdFromAuthenticationToken(token)


# Define Handler implementation
class ExpenseHandler(expenses_pb2_grpc.ExpensesServicer):

    def GetMultiExpenses(self, request, context):
        # Retrieve user ID
        userId = getUserIdFromContext(context)
        if userId is None:
            # TODO: return error code
            userId = "invalid"

        context.set_code(grpc.StatusCode.OK)
        returnlist = expenses_pb2.MultiExpenseReply()
        returnlist.expenses.extend([
            from_mongo(entry) for entry in db.find({'userID': userId})
        ])
        return returnlist

    def GetOneExpense(self, request, context):
        expense_id = request.expenseID

        # Retrieve user ID
        userId = getUserIdFromContext(context)
        if userId is None:
            # TODO: return error code
            userId = "invalid"

        # BSON requirement: expense ID has to be proper type
        if isinstance(expense_id, str) and len(expense_id) == 24:
            expense_id = ObjectId(expense_id)

        # Query mongoDB
        expense = db.find_one({'_id': expense_id, 'userID': userId})
        if expense is None:
            # TODO: return error code
            context.set_code(grpc.StatusCode.OK)
            return expenses_pb2.Expense()

        # Create response
        expense = from_mongo(expense)
        context.set_code(grpc.StatusCode.OK)
        return expense

    def CreateOneExpense(self, request, context):
        userId = getUserIdFromContext(context)
        if userId is None:
            # TODO: return error code
            userId = "invalid"
        request.userID = userId
        expense = to_mongo(request)
        db.insert_one(expense)
        return from_mongo(expense)


# Define server context
def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    expenses_pb2_grpc.add_ExpensesServicer_to_server(ExpenseHandler(), server)
    server.add_insecure_port(f"[::]:{config['server']['port']}")
    server.start()
    server.wait_for_termination()


if __name__ == '__main__':
    logging.basicConfig()
    serve()
