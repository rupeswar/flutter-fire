import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire/utils/dialogs.dart';

class EmailAuth {
  createUser(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showUserAlreadyRegisteredDialog(context);
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signInUser(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      // UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showUserNotRegisteredDialog(context);
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  showUserAlreadyRegisteredDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context) => EmailAlreadyRegistered());
  }

  showUserNotRegisteredDialog(BuildContext context) {
    showDialog(
        context: context, builder: (context) => EmailNotRegisteredPopUp());
  }
}
