import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/component/button.dart';
import 'package:note/component/textfield.dart';
import 'package:note/screens/login/controller.dart';
import 'package:note/screens/login/states.dart';
import 'package:note/screens/register/view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => LoginController(),
      child: BlocConsumer<LoginController, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = LoginController.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                    EdgeInsets.symmetric(horizontal: size.shortestSide * .04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: size.longestSide * .3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(
                                fontSize: size.shortestSide * .12,
                                fontFamily: 'head'),
                          ),
                          Image.network(
                              "http://simpleicon.com/wp-content/uploads/note-2.png",
                              height: size.longestSide * .1),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.longestSide * .01,
                    ),
                    TextFieldItem(
                      hint: "Email",
                      size: size,
                      value: controller.email,
                    ),
                    SizedBox(
                      height: size.longestSide * .02,
                    ),
                    TextFieldItem(
                      isPassword: true,
                      isSecure: controller.isSwitch,
                      hint: "Password",
                      onPress: () => controller.changeVisual(),
                      size: size,
                      value: controller.password,
                    ),
                    Row(
                      children: [
                        Checkbox(value: true, onChanged: (val) {}),
                        Text(
                          "Remember me",
                          style: TextStyle(
                              fontSize: size.shortestSide * .05,
                              color: Colors.grey.shade700),
                        )
                      ],
                    ),
                    SizedBox(
                      height: size.longestSide * .02,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.shortestSide * .06,
                          vertical: size.longestSide * .02),
                      child: ButtonItem(
                        size: size,
                        onPress: () async {
                          await controller.login(context);
                        },
                        name: "Login",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have acount yet?  ",
                            style: TextStyle(
                              fontSize: size.shortestSide * .04,
                            )),
                        InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()),
                                  (route) => false);
                            },
                            child: Text("Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue,
                                  fontSize: size.shortestSide * .04,
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
