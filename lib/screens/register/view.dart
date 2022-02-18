import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/component/button.dart';
import 'package:note/component/textfield.dart';
import 'package:note/screens/login/view.dart';
import 'package:note/screens/register/controller.dart';
import 'package:note/screens/register/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => RegisterController(),
      child: BlocConsumer<RegisterController, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final controller = RegisterController.get(context);
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
                            "Register",
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
                      validtion: (val) => controller.validation.userName(val),
                      hint: "Username",
                      size: size,
                      value: controller.userName,
                    ),
                    SizedBox(
                      height: size.longestSide * .02,
                    ),
                    TextFieldItem(
                      validtion: (val) => controller.validation.email(val),
                      hint: "Email",
                      size: size,
                      value: controller.email,
                    ),
                    SizedBox(
                      height: size.longestSide * .02,
                    ),
                    TextFieldItem(
                      validtion: (val) => controller.validation.password(val),
                      isPassword: true,
                      isSecure: controller.isSwitch,
                      hint: "Password",
                      onPress: () => controller.changeVisual(),
                      size: size,
                      value: controller.password,
                    ),
                    SizedBox(
                      height: size.longestSide * .05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.shortestSide * .06,
                          vertical: size.longestSide * .02),
                      child: ButtonItem(
                        size: size,
                        onPress: () async {
                          if (controller.validation.formKey.currentState!
                              .validate()) {
                            await controller.register(context);
                          }
                        },
                        name: "Register",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Have acount already?  ",
                            style: TextStyle(
                              fontSize: size.shortestSide * .04,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                              fontSize: size.shortestSide * .04,
                            ),
                          ),
                        ),
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
