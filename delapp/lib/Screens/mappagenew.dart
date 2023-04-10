// ignore_for_file: avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, use_build_context_synchronously, non_constant_identifier_names

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:delapp/Screens/cards.dart';
import 'package:delapp/Screens/deliveredModel.dart';
import 'package:delapp/Screens/initFucntions.dart';
import 'package:delapp/Screens/kkn.dart';
import 'package:flutter/material.dart';

// import 'package:mapapi/pages/map.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();
    final TextEditingController _NoteController = TextEditingController();
    return Scaffold(
      backgroundColor: MyTheme.courseCardColor,
      appBar: AppBar(
        title: const Text('Current Orders'),
      ),
      body: jsonData.runtimeType == List
          ? Stack(
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
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32.0))),
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
                            const Text('Current Order',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold)),
                            Text(
                                currentOrderDetails["orderedByName"].toString(),
                                style: TextStyle(
                                    fontSize: 20, color: MyTheme.grey)),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rs. ${currentOrderDetails["amount"]}",
                                  style: const TextStyle(fontSize: 17),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    currentOrderDetails["deliverAt"].toString(),
                                    style: const TextStyle(fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Column(children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text("Enter OTP"),
                                                  content: TextField(
                                                    controller: _otpController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: "OTP"),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child:
                                                          const Text("Submit"),
                                                      onPressed: () async {
                                                        String otp =
                                                            _otpController.text;
                                                        var p = await delivered(
                                                            otp);
                                                        Navigator.of(context)
                                                            .pop();
                                                        if (p["delivered"] ==
                                                            true) {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                snackBar);
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                              context)
                                                            ..hideCurrentSnackBar()
                                                            ..showSnackBar(
                                                                WrongsnackBar);
                                                        }
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          const Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Text('Delivered')),
                                  ),
                                  // ignore: prefer_const_constructors
                                  SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    height: 40,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Reason"),
                                                  content: TextField(
                                                    controller: _NoteController,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Eg. User not at home"),
                                                  ),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child:
                                                          const Text("Submit"),
                                                      onPressed: () async {
                                                        // String otp =
                                                        //     _otpController.text;
                                                        // await delivered(otp);
                                                        // print("Name entered: $name");
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child:
                                                          const Text("Cancel"),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              });
                                        },
                                        child: const Text('Cancel Order')),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                    child: Text(
                                      "Other Orders",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: ListView.builder(
                                        itemCount: currentRoundDetails.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return CardFb3(
                                              text: "OrderId " +
                                                  currentRoundDetails[index]
                                                          ["orderId"]
                                                      .toString(),
                                              subtitle: "Rs. " +
                                                  currentRoundDetails[index]
                                                          ["amount"]
                                                      .toString(),
                                              address:
                                                  currentRoundDetails[index]
                                                          ["deliverAt"]
                                                      .toString(),
                                              onPressed: () {});
                                        }),
                                  )
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
            )
          : const Center(child: Text("No Current Orders")),
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

final snackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Delivery Completed Successfully!',
    message: 'Kindly Refresh the page to go to the next order.',
    contentType: ContentType.success,
  ),
);

final WrongsnackBar = SnackBar(
  elevation: 0,
  behavior: SnackBarBehavior.floating,
  backgroundColor: Colors.transparent,
  content: AwesomeSnackbarContent(
    title: 'Incorrect OTP!',
    message: 'Kindly enter the correct OTP.',
    contentType: ContentType.failure,
  ),
);
