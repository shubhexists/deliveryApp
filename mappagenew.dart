// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mapapi/models/kkn.dart';
import 'package:http/http.dart' as http;
// import 'package:mapapi/pages/map.dart';

class CourseScreen extends StatelessWidget {
  final String courseName;
  final String courseInfo;
  final String coursePrice;

  const CourseScreen(
      {Key? key,
      required this.courseName,
      required this.courseInfo,
      required this.coursePrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.courseCardColor,
      appBar: AppBar(
        title: const Text('Current Orders'),
      ),
      body: Stack(
        children: [
          // ignore: prefer_const_literals_to_create_immutables
          Column(children: [
            const Expanded(
              flex: 100,
              child: Center(child: POIAlongRouteWidget()),
            ),
            const Spacer(
              flex: 65,
            )
          ]),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32.0))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyTheme.grey.withOpacity(0.5),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(1.0))),
                          height: 4,
                          width: 48,
                        ),
                      ),
                      MyTheme.mediumVerticalPadding,
                      Text(courseName,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      Text(courseInfo,
                          style: TextStyle(fontSize: 20, color: MyTheme.grey)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Rs. 130",
                            style: TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                              coursePrice.substring(0, 45),
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            coursePrice.substring(
                              45,
                            ),
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Column(children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    // var response = await http.post(Uri.parse(
                                    //     "http://156.67.219.185:8000/api/delivery/delivered"),
                                    //     headers: {'Content-Type': 'application/json'},
                                    //     body: jsonEncode({
                                    //       "orderId" : ,
                                    //       "otp" : otp
                                    //     }));
                                  },
                                  child: const Text('Delivered')),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Cancel Order')),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyTheme {
  static Color get backgroundColor => const Color(0xFFF7F7F7);
  static Color get grey => const Color(0xFF999999);
  static Color get catalogueCardColor =>
      const Color(0xFFBAE5D4).withOpacity(0.5);
  static Color get catalogueButtonColor => const Color(0xFF29335C);
  static Color get courseCardColor => const Color(0xFFEDF1F1);
  static Color get progressColor => const Color(0xFF36F1CD);

  static Padding get largeVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 32.0));

  static Padding get mediumVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 16.0));

  static Padding get smallVerticalPadding =>
      const Padding(padding: EdgeInsets.only(top: 8.0));

  static ThemeData get theme => ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blueGrey,
      ).copyWith(
        cardTheme: const CardTheme(
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0.0),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
                catalogueButtonColor), // Button color
            foregroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Text and icon color
          ),
        ),
      );
}
