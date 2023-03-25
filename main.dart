// ignore_for_file: prefer_typing_uninitialized_variables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:mapapi/models/initFucntions.dart';
import 'package:mapapi/pages/LoginPage/loginPage.dart';
// import 'package:mapapi/models/kkn.dart';
// import 'package:mapapi/pages/MapPage/mappagenew.dart';
// import 'package:mapapi/pages/ProfilePage/profilePage.dart';
import 'package:mapapi/pages/bottomBar.dart';
import 'package:mapapi/pages/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

var dboy;
Widget _defaultHome = const LoginScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await tryautologin();

  await getDeliveryBoyDetails();
  await MapMyIndiaAuth();
  await getRoundDetails();

  runApp(const MyApp());
}

var _token;
Future<void> tryautologin() async {
  final prefs = await SharedPreferences.getInstance();
// if (!prefs.containsKey('token')) {
//   return false;
//   }
  // ignore: non_constant_identifier_names
  final token_check = prefs.getString('token');
  if (token_check != null) {
    _defaultHome = const bottomBar();
    _token = token_check;
    return _token;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _defaultHome);
  }
}
