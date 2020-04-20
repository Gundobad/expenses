import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:grpc/grpc.dart';

import 'proto-compiled/expenses.pb.dart';
import 'proto-compiled/expenses.pbgrpc.dart';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

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
      home: _EmailPasswordForm(),
    );
  }
}

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

  void _checkGrpc() {
    var temp = () async {
      List<Expense> expenses = new List<Expense>();
      final channel = ClientChannel(
        '192.168.0.229',
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final stub = ExpensesClient(channel);

      final userId = "dj";

      try {
        var response = await stub
            .getMultiExpenses(MultiExpensesRequest()..userID = userId);
        expenses = response.expenses;
      } catch (e) {
        print('Caught error: $e');
      }
      await channel.shutdown();
      return expenses;
    };

    temp().then((expenseslist) {
      setState(() {
        _expenses = _convertToCards(expenseslist);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _checkGrpc();
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
              _checkGrpc();
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
            _EmailPasswordForm(),
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
            _checkGrpc();
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _EmailPasswordForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<_EmailPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("User Area")),
        ),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: const Text('Sign in with email and password'),
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      alignment: Alignment.center,
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _signInWithEmailAndPassword();
                          }
                        },
                        child: const Text('Sign in'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _success == null
                            ? ''
                            : (_success
                                ? 'Successfully signed in ' + _userEmail
                                : 'Sign in failed'),
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Example code of how to sign in with email and password.
  void _signInWithEmailAndPassword() async {
    print("Signing in with email [" +
        _emailController.text +
        "] and pw [" +
        _passwordController.text +
        "]");

    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
      } else {
        _success = false;
      }
    } catch (e) {
      print("Caught error: " + e.toString());
      // TODO: error highlighting on error, depending on kind of error
      // TODO: trim spaces
      setState(() {
        _success = false;
      });
    }
  }
}

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

  void createNewExpense() {
    Expense e = new Expense()
      ..winkelID = _shopTextController.text
      ..price = double.parse(cleanUpDoubleText(_paymentTextController.text))
      ..summary = "default"
      ..timestamp = _dateTextController.text + " " + _timeTextController.text;

    var temp = (exp) async {
      final channel = ClientChannel(
        '192.168.0.229',
        port: 50051,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      final stub = ExpensesClient(channel);

      try {
        await stub.createOneExpense(exp);
      } catch (e) {
        print('Caught error: $e');
      }
      await channel.shutdown();
    };

    temp(e);
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
