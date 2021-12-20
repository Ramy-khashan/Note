import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  getData() async {
    FirebaseFirestore.instance
        .collection('note')
        .where("uid", isEqualTo: uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        data.add(element);
      });
      isDoneLoad = true;
      emit(DoneGetDataState());
    });
  }
}
