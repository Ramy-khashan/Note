import 'package:flutter/material.dart';
import 'package:regexpattern/regexpattern.dart';

class Validation {
  var formKey = GlobalKey<FormState>();
  String? userName(String value) {
    if (value.isEmpty) {
      return 'Enter UserName';
    } else if (!value.isTxt()) {
      return 'Enter userName Correct';
    }
  }

  String? email(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Email';
    } else if (!value.isEmail()) {
      val = 'Enter Yout Email Correct';
    }
    return val;
  }

  String? password(String value) {
    String? val;
    if (value.isEmpty) {
      val = 'Enter Your Password';
    } else if (!value.isPasswordNormal1()) {
      val = 'Enter Your Password Correct';
    }
    return val;
  }
}
