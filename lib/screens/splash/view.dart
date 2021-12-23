import 'package:flutter/material.dart';
import 'package:note/screens/splash/controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = SplahController();
  @override
  void initState() {
    controller.timer(context);
    super.initState();
  }

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
