// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, use_build_context_synchronously
import 'package:delapp/Screens/cards.dart';
import 'package:delapp/Screens/initFucntions.dart';
import 'package:delapp/Screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF26CBE6),
              Color(0xFF26CBC0),
            ], begin: Alignment.topCenter, end: Alignment.center)),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: _height / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage:
                                const AssetImage('assets/avatar.jpg'),
                            radius: _height / 10,
                          ),
                          SizedBox(
                            height: _height / 35,
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: _height / 2.2),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: _height / 2.6,
                        left: _width / 20,
                        right: _width / 20),
                    child: Column(
                      children: [
                        Text(
                          Star,
                          style: const TextStyle(fontSize: 25),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: _height / 25),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 1,
                                ),
                                CardFb2(
                                    text: "Total Deliveries Made ",
                                    subtitle: totalDeliveries,
                                    onPressed: () {}),
                                const SizedBox(
                                  height: 1,
                                ),
                                CardFb2(
                                    text: "On Time Deliveries",
                                    subtitle: onTimeDeliveries,
                                    onPressed: () {}),
                                const SizedBox(
                                  height: 1,
                                ),
                                CardFb2(
                                    text: "Vendor",
                                    subtitle: vendor,
                                    onPressed: () {}),
                                const SizedBox(
                                  height: 1,
                                ),
                                CardFb2(
                                    text: "Get Help with the App",
                                    subtitle: "",
                                    onPressed: () {}),
                                Padding(
                                  padding: EdgeInsets.only(top: _height / 39),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: MaterialStateProperty.all(0),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  0, 255, 255, 255)),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  0, 255, 255, 255)),
                                    ),
                                    onPressed: () async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      await preferences.clear();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen()));
                                    },
                                    child: Container(
                                      width: _width,
                                      height: _height / 20,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF26CBE6),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(_height / 40)),
                                          // ignore: prefer_const_literals_to_create_immutables
                                          boxShadow: [
                                            const BoxShadow(
                                                color: Colors.black87,
                                                blurRadius: 2.0,
                                                offset: Offset(0.0, 1.0))
                                          ]),
                                      child: const Center(
                                        child: Text('Log Out',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
