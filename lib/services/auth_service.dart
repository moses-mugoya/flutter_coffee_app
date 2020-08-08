import 'package:coffee_app/models/user.dart';
import 'package:coffee_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String error_message;

  //get user from firebase into custom user
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Streams to listen to auth changes
  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  //method to sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _firebaseAuth.signInAnonymously();
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserRecords('0', 'user', 100);
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  //method to sign up with email and password
  Future signUpWithEmailAndPass(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserRecords('0', 'user', 100);
      return _userFromFirebase(user);
    } catch (e) {
      error_message = e.message;
      return null;
    }
  }

  //method to sign in with email and password
  Future signInWithEmailAndPas(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      error_message = e.message;
      return null;
    }
  }

  // method to signout
  Future signOut() async {
    _firebaseAuth.signOut();
  }
}
