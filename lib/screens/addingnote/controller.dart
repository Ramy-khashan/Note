import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:note/screens/addingnote/states.dart';
import 'package:note/screens/homepage/view.dart';

class AddingNoteController extends Cubit<AddingNoteState> {
  final titleController = TextEditingController();
  final noteDetailsController = TextEditingController();
  bool isDone = false;

  AddingNoteController() : super(InitalAddingNoteState());
  static AddingNoteController get(context) => BlocProvider.of(context);
  uploadNote(context) async {
    isDone = true;
    emit(DoneState());

    FirebaseFirestore.instance.collection('note').add({
      'title': titleController.text.trim(),
      'noteDetails': noteDetailsController.text.trim(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': DateFormat.MMMEd().format(DateTime.now()),
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
          (route) => false);
    });
  }

  updateNote(context, docId) async {
    isDone = true;
    emit(UpdateState());

    FirebaseFirestore.instance.collection('note').doc(docId).update({
      'title': titleController.text.trim(),
      'noteDetails': noteDetailsController.text.trim(),
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': DateFormat.MMMMEEEEd().format(DateTime.now()),
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
          (route) => false);
    });
  }

  startValue(isUpdate, title, note) {
    if (isUpdate == true) {
      titleController.text = title;
      noteDetailsController.text = note;
    }
  }
}
