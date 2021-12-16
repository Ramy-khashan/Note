import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/register/states.dart';

class RegisterController extends Cubit<RegisterStates> {
  final userName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool isSwitch = true;

  RegisterController() : super(InitialRegisterState());
  static RegisterController get(context) => BlocProvider.of(context);
  void changeVisual() {
    emit(ChangeShowRegisterState());
    isSwitch = !isSwitch;
  }

  UserCredential? user;
  Future<void> register(context) async {
    try {
      user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('The password provided is too weak.'),
            )).show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('The account already exists for that email.'),
            )).show();
      }
    }
  }
}
