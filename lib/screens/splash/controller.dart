import 'dart:async';

import 'package:flutter/material.dart';
import 'package:note/screens/login/view.dart';

class SplahController {
  timer(context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            )).tick;
  }
}
