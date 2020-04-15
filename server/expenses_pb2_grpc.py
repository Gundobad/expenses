# Generated by the gRPC Python protocol compiler plugin. DO NOT EDIT!
import grpc

import expenses_pb2 as expenses__pb2


class ExpensesStub(object):
    """Service with methods for retrieving either one or all expenses made
    """

    def __init__(self, channel):
        """Constructor.

        Args:
            channel: A grpc.Channel.
        """
        self.GetMultiExpenses = channel.unary_unary(
                '/expsenses.Expenses/GetMultiExpenses',
                request_serializer=expenses__pb2.MultiExpensesRequest.SerializeToString,
                response_deserializer=expenses__pb2.MultiExpenseReply.FromString,
                )
        self.GetOneExpense = channel.unary_unary(
                '/expsenses.Expenses/GetOneExpense',
                request_serializer=expenses__pb2.ExpenseRequest.SerializeToString,
                response_deserializer=expenses__pb2.Expense.FromString,
                )
        self.CreateOneExpense = channel.unary_unary(
                '/expsenses.Expenses/CreateOneExpense',
                request_serializer=expenses__pb2.Expense.SerializeToString,
                response_deserializer=expenses__pb2.Expense.FromString,
                )


class ExpensesServicer(object):
    """Service with methods for retrieving either one or all expenses made
    """

    def GetMultiExpenses(self, request, context):
        """GET all expenses
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def GetOneExpense(self, request, context):
        """GET one expense
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')

    def CreateOneExpense(self, request, context):
        """POST one expense
        """
        context.set_code(grpc.StatusCode.UNIMPLEMENTED)
        context.set_details('Method not implemented!')
        raise NotImplementedError('Method not implemented!')


def add_ExpensesServicer_to_server(servicer, server):
    rpc_method_handlers = {
            'GetMultiExpenses': grpc.unary_unary_rpc_method_handler(
                    servicer.GetMultiExpenses,
                    request_deserializer=expenses__pb2.MultiExpensesRequest.FromString,
                    response_serializer=expenses__pb2.MultiExpenseReply.SerializeToString,
            ),
            'GetOneExpense': grpc.unary_unary_rpc_method_handler(
                    servicer.GetOneExpense,
                    request_deserializer=expenses__pb2.ExpenseRequest.FromString,
                    response_serializer=expenses__pb2.Expense.SerializeToString,
            ),
            'CreateOneExpense': grpc.unary_unary_rpc_method_handler(
                    servicer.CreateOneExpense,
                    request_deserializer=expenses__pb2.Expense.FromString,
                    response_serializer=expenses__pb2.Expense.SerializeToString,
            ),
    }
    generic_handler = grpc.method_handlers_generic_handler(
            'expsenses.Expenses', rpc_method_handlers)
    server.add_generic_rpc_handlers((generic_handler,))


 # This class is part of an EXPERIMENTAL API.
class Expenses(object):
    """Service with methods for retrieving either one or all expenses made
    """

    @staticmethod
    def GetMultiExpenses(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/expsenses.Expenses/GetMultiExpenses',
            expenses__pb2.MultiExpensesRequest.SerializeToString,
            expenses__pb2.MultiExpenseReply.FromString,
            options, channel_credentials,
            call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def GetOneExpense(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/expsenses.Expenses/GetOneExpense',
            expenses__pb2.ExpenseRequest.SerializeToString,
            expenses__pb2.Expense.FromString,
            options, channel_credentials,
            call_credentials, compression, wait_for_ready, timeout, metadata)

    @staticmethod
    def CreateOneExpense(request,
            target,
            options=(),
            channel_credentials=None,
            call_credentials=None,
            compression=None,
            wait_for_ready=None,
            timeout=None,
            metadata=None):
        return grpc.experimental.unary_unary(request, target, '/expsenses.Expenses/CreateOneExpense',
            expenses__pb2.Expense.SerializeToString,
            expenses__pb2.Expense.FromString,
            options, channel_credentials,
            call_credentials, compression, wait_for_ready, timeout, metadata)
