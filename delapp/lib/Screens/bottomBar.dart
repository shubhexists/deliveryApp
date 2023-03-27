// ignore_for_file: file_names, camel_case_types
import 'package:delapp/Screens/initFucntions.dart';
import 'package:delapp/Screens/mappagenew.dart';
import 'package:delapp/Screens/pastorders.dart';
import 'package:delapp/Screens/profilePage.dart';
import 'package:flutter/material.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int currentIndex = 0;
  chooseBody() {
    if (currentIndex == 0) {
      return CourseScreen(
          courseName: 'Current Order',
          courseInfo: currentOrderDetails["orderedByName"].toString(),
          coursePrice: currentOrderDetails["deliverAt"].toString());
    } else if (currentIndex == 1) {
      return const PastOrdersPage();
    } else {
      return const MyHomePage(title: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chooseBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              label: 'Current Orders',
              backgroundColor: Colors.blue),
          const BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_outlined),
              label: 'Past Orders',
              backgroundColor: Colors.blue),
          const BottomNavigationBarItem(
              icon: Icon(Icons.man_outlined),
              label: 'Profile',
              backgroundColor: Colors.blue)
        ],
      ),
    );
  }
}
