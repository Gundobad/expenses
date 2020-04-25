import 'package:flutter/material.dart';

import '../proto-compiled/expenses.pb.dart';
import '../proto-compiled/expenses.pbgrpc.dart';

import 'createExpense.dart';
import '../connection/connection.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  final String title = "Expense Tracker";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Card> _expenses = List<Card>();

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

  List<Card> _convertToCards(List<Expense> expenses) {
    List<Card> cards = new List<Card>();
    for (Expense expense in expenses) {
      cards.add(_convertToCard(expense));
    }
    if (cards.isEmpty) {
      cards.add(new Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('No expenses available yet. '),
              subtitle: Text(
                  'You can add a new expense by tapping the button in the bottom right of your screen.'),
            ),
          ],
        ),
      ));
    }
    return cards;
  }

  void _updateExpenseCards() async {
     final expenses = await ConnectionManager.getMultiExpenses();

    setState(() {
      _expenses = _convertToCards(expenses);
    });
  }

  @override
  void initState() {
    super.initState();
    _updateExpenseCards();
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
              _updateExpenseCards();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView(
                  padding: const EdgeInsets.all(8), children: _expenses),
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
            _updateExpenseCards();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
