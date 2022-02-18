import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/flashpage/states.dart';
import 'package:note/screens/homepage/view.dart';
import 'package:note/screens/register/view.dart';

class FlashController extends Cubit<FlashState> {
  FlashController() : super(InitalFlashState());
  static FlashController get(context) => BlocProvider.of(context);

  timer(context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
          (route) => false);
    });
  }
}
