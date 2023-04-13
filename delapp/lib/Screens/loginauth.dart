// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:delapp/Screens/bottomBar.dart';
import 'package:delapp/Screens/initFucntions.dart';
import 'package:delapp/Screens/loginPage.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

var token;
var prefs;
final errorsnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    contentType: ContentType.failure,
    title: 'Invalid Credentials',
    message: 'Kindly check the details and try again',
  ),
);

login(BuildContext context, String email, password) async {
  try {
    Response response = await post(
        Uri.parse('http://156.67.219.185:8000/api/delivery/login'),
        body: {'user': email, 'password': password});
    if (response.statusCode != 201) {
      var data = jsonDecode(response.body.toString());
      var token = data;
      print(token);
      prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token['token'].toString());
      await getDeliveryBoyDetails();
      await getRoundDetails();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const bottomBar()));
      return prefs;
    } else if (response.statusCode == 201) {
      await Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  } catch (e) {
    print(e.toString());
  }
}
