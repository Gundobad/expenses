import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import '../proto-compiled/expenses.pb.dart';

import '../connection/connection.dart';

class CreateExpenseView extends StatefulWidget {
  CreateExpenseView({Key key}) : super(key: key);

  @override
  _CreateExpenseViewState createState() => _CreateExpenseViewState();
}

class _CreateExpenseViewState extends State<CreateExpenseView> {
  static final TextEditingController _shopTextController =
      TextEditingController();
  static final TextEditingController _paymentTextController =
      TextEditingController();
  static final TextEditingController _dateTextController =
      TextEditingController();
  static final TextEditingController _timeTextController =
      TextEditingController();

  static const List<String> coded = [","]; //ABV list
  static const List<String> decoded = ["."]; //corresponding list
  static final Map<String, String> _doubleTextCleanup =
      new Map.fromIterables(coded, decoded);

  static String cleanUpDoubleText(String old) {
    return _doubleTextCleanup.entries
        .fold(old, (prev, e) => prev.replaceAll(e.key, e.value));
  }

  @override
  void initState() {
    super.initState();
    _shopTextController.text = "";
    _paymentTextController.text = "";

    var now = new DateTime.now();
    _dateTextController.text = (new DateFormat('dd/MM/yyyy')).format(now);
    _timeTextController.text = (new DateFormat('HH:mm')).format(now);
  }

  void createNewExpense() async {
    Expense e = new Expense()
      ..winkelID = _shopTextController.text
      ..price = double.parse(cleanUpDoubleText(_paymentTextController.text))
      ..summary = "default"
      ..timestamp = _dateTextController.text + " " + _timeTextController.text;

      ConnectionManager.createOneExpense(e);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("New expense"),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    SizedBox(height: 60),
                    TextField(
                      controller: _shopTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Shop',
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _paymentTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Payment',
                      ),
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _dateTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Date',
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _timeTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Time',
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                    SizedBox(height: 40),
                    RaisedButton(
                      onPressed: () {
                        createNewExpense();
                      },
                      child:
                          const Text('Create', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ))
              ]),
        ));
  }
}
