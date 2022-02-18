import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:note/screens/flashpage/view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xfffffffd),
        primaryColor: const Color(0xffd4a45c),
      ),
      debugShowCheckedModeBanner: false,
      home: const FlashScreen(),
    );
  }
}
