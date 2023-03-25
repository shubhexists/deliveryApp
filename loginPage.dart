// ignore_for_file: file_names
// ignore: unused_import

import 'package:flutter/material.dart';
import 'package:mapapi/models/loginauth.dart';
import 'package:mapapi/pages/LoginPage/features/email_field.dart';
import 'package:mapapi/pages/LoginPage/features/getStartedButton.dart';
import 'package:mapapi/pages/LoginPage/features/password_field.dart';
import 'package:mapapi/pages/bottomBar.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final double _elementsOpacity = 1;
  bool loadingBallAppear = false;
  double loadingBallSize = 1;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.black),
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          subtitle1: TextStyle(color: Colors.black), //<-- SEE HERE
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: false,
          child: loadingBallAppear
              ? const bottomBar()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 70),
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 300),
                          tween: Tween(begin: 1, end: _elementsOpacity),
                          builder: (_, value, __) => Opacity(
                            opacity: value,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.flutter_dash,
                                    size: 60, color: Color(0xff21579C)),
                                const SizedBox(height: 25),
                                const Text(
                                  "Welcome,",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 35),
                                ),
                                Text(
                                  "Sign in to continue",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 35),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              EmailField(
                                  fadeEmail: _elementsOpacity == 0,
                                  emailController: emailController),
                              const SizedBox(height: 40),
                              PasswordField(
                                  fadePassword: _elementsOpacity == 0,
                                  passwordController: passwordController),
                              const SizedBox(height: 60),
                              GetStartedButton(
                                elementsOpacity: _elementsOpacity,
                                onTap: () {
                                  // setState(() {
                                  //   _elementsOpacity = 0;
                                  // });
                                  login(
                                      context,
                                      emailController.text.toString(),
                                      passwordController.text.toString());
                                },
                                onAnimatinoEnd: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 500));
                                  setState(() {
                                    loadingBallAppear = true;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
