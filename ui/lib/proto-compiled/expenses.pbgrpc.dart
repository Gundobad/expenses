///
//  Generated code. Do not modify.
//  source: expenses.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'expenses.pb.dart' as $0;
export 'expenses.pb.dart';

class ExpensesClient extends $grpc.Client {
  static final _$getMultiExpenses =
      $grpc.ClientMethod<$0.MultiExpensesRequest, $0.MultiExpenseReply>(
          '/expsenses.Expenses/GetMultiExpenses',
          ($0.MultiExpensesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.MultiExpenseReply.fromBuffer(value));
  static final _$getOneExpense =
      $grpc.ClientMethod<$0.ExpenseRequest, $0.Expense>(
          '/expsenses.Expenses/GetOneExpense',
          ($0.ExpenseRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.Expense.fromBuffer(value));
  static final _$createOneExpense = $grpc.ClientMethod<$0.Expense, $0.Expense>(
      '/expsenses.Expenses/CreateOneExpense',
      ($0.Expense value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Expense.fromBuffer(value));

  ExpensesClient($grpc.ClientChannel channel, {$grpc.CallOptions options})
      : super(channel, options: options);

  $grpc.ResponseFuture<$0.MultiExpenseReply> getMultiExpenses(
      $0.MultiExpensesRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getMultiExpenses, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.Expense> getOneExpense($0.ExpenseRequest request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$getOneExpense, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }

  $grpc.ResponseFuture<$0.Expense> createOneExpense($0.Expense request,
      {$grpc.CallOptions options}) {
    final call = $createCall(
        _$createOneExpense, $async.Stream.fromIterable([request]),
        options: options);
    return $grpc.ResponseFuture(call);
  }
}

abstract class ExpensesServiceBase extends $grpc.Service {
  $core.String get $name => 'expsenses.Expenses';

  ExpensesServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.MultiExpensesRequest, $0.MultiExpenseReply>(
            'GetMultiExpenses',
            getMultiExpenses_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.MultiExpensesRequest.fromBuffer(value),
            ($0.MultiExpenseReply value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExpenseRequest, $0.Expense>(
        'GetOneExpense',
        getOneExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExpenseRequest.fromBuffer(value),
        ($0.Expense value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Expense, $0.Expense>(
        'CreateOneExpense',
        createOneExpense_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Expense.fromBuffer(value),
        ($0.Expense value) => value.writeToBuffer()));
  }

  $async.Future<$0.MultiExpenseReply> getMultiExpenses_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.MultiExpensesRequest> request) async {
    return getMultiExpenses(call, await request);
  }

  $async.Future<$0.Expense> getOneExpense_Pre(
      $grpc.ServiceCall call, $async.Future<$0.ExpenseRequest> request) async {
    return getOneExpense(call, await request);
  }

  $async.Future<$0.Expense> createOneExpense_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Expense> request) async {
    return createOneExpense(call, await request);
  }

  $async.Future<$0.MultiExpenseReply> getMultiExpenses(
      $grpc.ServiceCall call, $0.MultiExpensesRequest request);
  $async.Future<$0.Expense> getOneExpense(
      $grpc.ServiceCall call, $0.ExpenseRequest request);
  $async.Future<$0.Expense> createOneExpense(
      $grpc.ServiceCall call, $0.Expense request);
}
