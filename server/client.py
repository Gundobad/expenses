import logging

import grpc

import expenses_pb2
import expenses_pb2_grpc
from datetime import datetime


def run():
    with grpc.insecure_channel('192.168.0.229:50051') as channel:
        stub = expenses_pb2_grpc.ExpensesStub(channel)
        # response = stub.CreateOneExpense(expenses_pb2.Expense(winkelID="fnac gent", price=9.5, timestamp=str(datetime.now()), summary="yolotanker"))
        # response = stub.GetMultiExpenses(expenses_pb2.MultiExpensesRequest())
        response = stub.GetOneExpense(expenses_pb2.ExpenseRequest())
    print(response)
    # print(len(response.expenses))


if __name__ == '__main__':
    logging.basicConfig()
    run()
