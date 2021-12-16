import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/login/states.dart';

class LoginController extends Cubit<LoginStates> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool isSwitch = false;

  LoginController() : super(InitialLoginState());
  static LoginController get(context) => BlocProvider.of(context);
  void changeVisual() {
    emit(ChangeShowLoginState());
    isSwitch = !isSwitch;
  }

  UserCredential? user;
  Future<void> login(context) async {
    try {
      user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No user found for that email.'),
            )).show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Wrong password provided for that user.'),
            )).show();
      }
    }
  }
}
