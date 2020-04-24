import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationManager {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseUser user;
  static FirebaseUser getUser() {
    return user;
  }

  static Future<bool> isCurrentlyLoggedIn() async {
    return user != null;
  }

  static void signIn({String email, String password}) async {
    final FirebaseUser newUser = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
      if (newUser.isEmailVerified) {
        user = newUser;
      }
      else {
        signOut();
      }
  }

  static void signOut() {
    _auth.signOut();
    user = null;
  }

  static Future<bool> register({String email, String password}) async {
    final FirebaseUser newUser = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;
    if (newUser == null) {
      return false;
    } else {
      try {
        await newUser.sendEmailVerification();
        return true;
      } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
        return false;
      }
    }
  }
}