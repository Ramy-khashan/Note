import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/screens/flashpage/controller.dart';
import 'package:note/screens/flashpage/states.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => FlashController()..timer(context),
      child: BlocConsumer<FlashController, FlashState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Image.network(
                "http://simpleicon.com/wp-content/uploads/note-2.png",
                height: size.longestSide * .5,
              ),
            ),
          );
        },
      ),
    );
  }
}
