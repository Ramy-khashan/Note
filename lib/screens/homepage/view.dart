import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:note/screens/addingnote/view.dart';
import 'package:note/screens/homepage/controller.dart';
import 'package:note/screens/homepage/state.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomePageController()..getData(),
      child: BlocConsumer<HomePageController, HomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = HomePageController.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title: Text(
                "Note",
                style: TextStyle(
                    fontFamily: 'head', fontSize: size.shortestSide * .075),
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
                    icon:
                        Icon(Icons.exit_to_app, size: size.shortestSide * .07)),
              ],
            ),
            body: !controller.isDoneLoad
                ? const Center(child: CircularProgressIndicator())
                : ReorderableListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: size.longestSide * .01,
                      horizontal: size.shortestSide * .02,
                    ),
                    children: List.generate(
                      controller.data.length,
                      (index) {
                        return Container(
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
                                controller.data[index]['title'],
                                style: TextStyle(
                                    fontSize: size.shortestSide * .058,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: size.longestSide * .015,
                              ),
                              Text(
                                controller.data[index]['noteDetails'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: size.shortestSide * .042,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                controller.data[index]['time'],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    onReorder: (int oldIndex, int newIndex) {
                      controller.changePosition(oldIndex, newIndex);
                    }),
            floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddingNoteScreen()));
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                )),
          );
        },
      ),
    );
  }
}
