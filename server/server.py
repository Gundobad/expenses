from concurrent import futures
import logging

import grpc
from pymongo import MongoClient
from bson.objectid import ObjectId

import expenses_pb2
import expenses_pb2_grpc


def from_mongo(e):
    return expenses_pb2.Expense(
        winkelID=e['winkelID'],
        price=e['price'],
        timestamp=e['timestamp'],
        summary=e['summary'],
        expenseID=str(e['_id'])
    )


def to_mongo(expense, id_set=False):
    dic = {
        "winkelID": expense.winkelID,
        "price": expense.price,
        "timestamp": expense.timestamp,
    }

    optional_fields = [('summary', "")]
    for field, default_value in optional_fields:
        dic[field] = (
            getattr(expense, field) if hasattr(expense, field)
            else default_value)

    if id_set:
        dic['expenseID'] = ObjectId(expense.expenseID)
    return dic


class ExpenseHandler(expenses_pb2_grpc.ExpensesServicer):

    def GetMultiExpenses(self, request, context):
        context.set_code(grpc.StatusCode.OK)
        returnlist = expenses_pb2.MultiExpenseReply()
        returnlist.expenses.extend([from_mongo(entry) for entry in db.find()])
        return returnlist

    def GetOneExpense(self, request, context):
        expense_id = request.expenseID

        # BSON requirement
        if isinstance(expense_id, str) and len(expense_id) == 24:
            expense_id = ObjectId(expense_id)

        # Query mongoDB
        expense = db.find_one({'_id': expense_id})
        if expense is None:
            context.set_code(grpc.StatusCode.OK)
            return expenses_pb2.Expense()

        # Create response
        expense = from_mongo(expense)
        context.set_code(grpc.StatusCode.OK)
        return expense

    def CreateOneExpense(self, request, context):
        expense = to_mongo(request)
        db.insert_one(expense)
        return from_mongo(expense)


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    expenses_pb2_grpc.add_ExpensesServicer_to_server(ExpenseHandler(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    server.wait_for_termination()


client = MongoClient('mongodb://db:27017/')
db = client['grpc_db']['expenses']


if __name__ == '__main__':
    logging.basicConfig()
    serve()
