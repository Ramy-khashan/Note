import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/screens/addingnote/states.dart';
import 'package:note/screens/homepage/view.dart';

class AddingNoteController extends Cubit<AddingNoteState> {
  final titleController = TextEditingController();
  final noteDetailsController = TextEditingController();
  bool isDone = false;

  AddingNoteController() : super(InitalAddingNoteState());
  static AddingNoteController get(context) => BlocProvider.of(context);
  uploadNote(context) {
    isDone = true;
    emit(DoneState());
    FirebaseFirestore.instance.collection('note').add({
      'title': titleController.text,
      'noteDetails': noteDetailsController.text,
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'time': DateFormat.MMMEd().format(DateTime.now())
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
          (route) => false);
    });
  }
}
