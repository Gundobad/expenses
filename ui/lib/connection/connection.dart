import 'dart:async';

import 'package:grpc/grpc.dart';

import '../proto-compiled/expenses.pbgrpc.dart';

import '../auth/auth.dart';

class ConnectionManager {
  static Future<void> getAuthHeader(
      Map<String, String> metadata, String uri) async {
    String tokenString = await AuthenticationManager.getToken();
    metadata.addAll({"Authentication": "Bearer $tokenString"});
  }

  static List<FutureOr<void> Function(Map<String, String>, String)> getHeaders(
      {bool auth}) {
    final contents =
        new List<FutureOr<void> Function(Map<String, String>, String)>();
    if (auth) {
      contents.add(getAuthHeader);
    }
    return contents;
  }

  static ClientChannel getChannel() {
    return ClientChannel(
      '192.168.0.229',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  static void createOneExpense(Expense expense) async {
    final channel = getChannel();
    final client = ExpensesClient(channel);
    try {
      await client.createOneExpense(expense,
          options: CallOptions(providers: getHeaders(auth: true)));
    } catch (e) {
      print('Caught error: $e');
    } finally {
      await channel.shutdown();
    }
  }

  static Future<List<Expense>> getMultiExpenses() async {
    final channel = getChannel();
    final client = ExpensesClient(channel);
    List<Expense> expenses = new List<Expense>();
    try {
      final response = await client.getMultiExpenses(MultiExpensesRequest(),
          options: CallOptions(providers: getHeaders(auth: true)));
      expenses = response.expenses;
    } catch (e) {
      print('Caught error: $e');
    } finally {
      await channel.shutdown();
    }
    return expenses;
  }
}
