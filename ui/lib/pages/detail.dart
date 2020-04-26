import 'package:flutter/material.dart';

import 'package:ExpenseTracker/proto-compiled/expenses.pb.dart';

class ExpenseDetail extends StatelessWidget {
  final Expense expense;

  ExpenseDetail({Key key, @required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO: add specific actions like delete, edit, etc.
        appBar: AppBar(
          title: Text("Expense detail"),
        ),
        body: Center(
          child: Column(children: [
            SizedBox(height: 30),
            Text(
              expense.winkelID,
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            Text(
              "€ " + expense.price.toString(),
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20),
            Text(
              expense.timestamp,
              style: TextStyle(fontSize: 18.0),
            ),
            // SizedBox(height: 30)
            Divider(
              thickness: 1,
              color: Color.fromRGBO(50, 50, 50, 0.6),
              height: 50,
            ),
            Text(
              expense.summary,
              style: TextStyle(fontSize: 18.0),
            ),
          ]),
        ));
  }
}
