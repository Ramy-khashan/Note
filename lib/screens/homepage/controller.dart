import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/homepage/view.dart';

import 'state.dart';

class HomePageController extends Cubit<HomePageState> {
  HomePageController() : super(InitalPageState());
  static HomePageController get(context) => BlocProvider.of(context);
  final List<int> items = List<int>.generate(10, (int index) => index);
  changePosition(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final int item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    emit(ChangePositionState());
  }

  bool isDoneLoad = false;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  List data = [];
  List docsId = [];
  getData() async {
    FirebaseFirestore.instance
        .collection('note')
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        docsId.add(element.id);
        data.add(element);
      });
      isDoneLoad = true;
      emit(DoneGetDataState());
    });
  }

  deleteNote(context, index, size) {
    AwesomeDialog(
        context: context,
        dismissOnTouchOutside: false,
        body: Column(
          children: [
            Text("You want to delete this note?",
                style: TextStyle(
                    fontSize: size.shortestSide * .047, fontFamily: "head")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("note")
                          .doc(docsId[index])
                          .delete()
                          .then((value) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePageScreen()),
                            (route) => false);
                      });
                    },
                    child: const Text(
                      "Ok",
                      style: TextStyle(fontFamily: 'button'),
                    )),
                SizedBox(width: size.shortestSide * .03),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cansle",
                    style: TextStyle(fontFamily: 'button'),
                  ),
                )
              ],
            ),
          ],
        )).show();
  }
}
