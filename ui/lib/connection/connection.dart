import 'dart:async';

import 'package:grpc/grpc.dart';

import '../proto-compiled/expenses.pbgrpc.dart';

import '../auth/auth.dart';

class ConnectionManager {
  static Future<void> getAuthHeader(Map<String, String> metadata, String uri) async {
    String tokenString = await AuthenticationManager.getToken();
      metadata.addAll({"Authentication": "Bearer $tokenString"});
  }

  static List<FutureOr<void> Function(Map<String, String>, String)> getHeaders({bool auth}){
    final contents = new List<FutureOr<void> Function(Map<String, String>, String)>();
    if (auth){
      contents.add(getAuthHeader);
    }
    return contents;
  }

  static void createOneExpense(Expense expense) async {
    final channel = ClientChannel(
        '192.168.0.229',
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
    final client =  ExpensesClient(channel);

    try {
        await client.createOneExpense(expense, options: CallOptions(providers: getHeaders(auth: true)));
      } catch (e) {
        print('Caught error: $e');
      }
      await channel.shutdown();
  }
}