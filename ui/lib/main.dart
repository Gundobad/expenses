import 'package:flutter/material.dart';

import 'pages/signin.dart';

void main() => runApp(ExpenseTracker());

class ExpenseTracker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense tracker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: EmailPasswordForm(),
    );
  }
}
