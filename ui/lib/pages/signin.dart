import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'signup.dart';

class EmailPasswordForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _EmailPasswordFormState();
}

class _EmailPasswordFormState extends State<EmailPasswordForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _success;
  String _userEmail;

  SharedPreferences logindata;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    logindata = await SharedPreferences.getInstance();
    bool loggedIn = (logindata.getBool('logged_in') ?? true);
    if (loggedIn == true) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                            if (await _signInWithEmailAndPassword())
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            new MyHomePage()));
                              });
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
                    ),
                    SizedBox(height: 20),
                    // Why InkWell? https://stackoverflow.com/a/56040244
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()));
                        },
                        child: new Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                              "Don't have an account? Sign up here!"),
                        )),
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
  Future<bool> _signInWithEmailAndPassword() async {
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
        logindata.setBool('logged_in', true);
        logindata.setString('username', user.uid);
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
    return _success;
  }
}