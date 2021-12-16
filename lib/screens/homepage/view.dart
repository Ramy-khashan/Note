import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note/screens/addingnote/view.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final List<int> _items = List<int>.generate(10, (int index) => index);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          "Note",
          style:
              TextStyle(fontFamily: 'head', fontSize: size.shortestSide * .075),
        ),
        actions: [
          IconButton(
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    title: 'You want to sign out !',
                    body: ElevatedButton(
                      child: const Text(
                        "Sign out",
                      ),
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ));
              },
              icon: Icon(Icons.exit_to_app, size: size.shortestSide * .07)),
        ],
      ),
      body: ReorderableListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            vertical: size.longestSide * .01,
            horizontal: size.shortestSide * .02,
          ),
          children: List.generate(
            10,
            (index) => Container(
              height: size.longestSide * .2,
              key: Key('$index'),
              padding: EdgeInsets.all(
                size.shortestSide * .025,
              ),
              margin: EdgeInsets.all(size.shortestSide * .03),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey.shade400,
                      spreadRadius: .5)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "title",
                    style: TextStyle(
                        fontSize: size.shortestSide * .06,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: size.longestSide * .015,
                  ),
                  Text(
                    "Body$index",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.shortestSide * .045,
                    ),
                  ),
                  const Spacer(),
                  Text(DateFormat.jm().format(DateTime.now())),
                ],
              ),
            ),
          ),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = _items.removeAt(oldIndex);
              _items.insert(newIndex, item);
            });
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddingNoteScreen()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}
