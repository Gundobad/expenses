import 'package:flutter/material.dart';

import '../proto-compiled/expenses.pb.dart';
import '../proto-compiled/expenses.pbgrpc.dart';

import 'createExpense.dart';
import '../connection/connection.dart';
import 'detail.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = "Expense Tracker";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Expense> _expenses = List<Expense>();

  Card _convertToCard(Expense expense) {
    var price = expense.price.toStringAsFixed(2);
    var winkel = expense.winkelID;
    var summary = expense.summary;
    return new Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Text('€$price'),
            title: Text('$winkel'),
            subtitle: Text('$summary'),
          ),
        ],
      ),
    );
  }

  void _updateExpenses() async {
    final expenses = await ConnectionManager.getMultiExpenses();

    setState(() {
      _expenses = expenses;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: add filtering of expense list with filter icon top right in the appbar
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // TODO: show broadcast mesage when reload succeeded
              _updateExpenses();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_expenses.isEmpty)
                ? Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        ListTile(
                          title: const Text('No expenses available yet. '),
                          subtitle: const Text(
                              'You can add a new expense by tapping the button in the bottom right of your screen.'),
                        ),
                      ],
                    ),
                  )
                : const Text(""),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: _convertToCard(_expenses[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExpenseDetail(expense: _expenses[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateExpenseView()),
          ).then((value) {
            _updateExpenses();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
