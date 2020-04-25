import 'package:flutter/material.dart';

import '../proto-compiled/expenses.pb.dart';
import '../proto-compiled/expenses.pbgrpc.dart';

import 'createExpense.dart';
import '../connection/connection.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // TODO: add filtering of expense list with filter icon top right in the appbar
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
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
        // onPressed: _checkGrpc, // _incrementCounter
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
