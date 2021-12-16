import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.network(
          "http://simpleicon.com/wp-content/uploads/note-2.png",
          height: size.longestSide * .5,
        ),
      ),
    );
  }
}
