// ignore_for_file: file_names, camel_case_types
import 'package:flutter/material.dart';
import 'package:mapapi/pages/MapPage/mappagenew.dart';
import 'package:mapapi/pages/PastOrders/pastorders.dart';
import 'package:mapapi/pages/ProfilePage/profilePage.dart';

class bottomBar extends StatefulWidget {
  const bottomBar({super.key});

  @override
  State<bottomBar> createState() => _bottomBarState();
}

class _bottomBarState extends State<bottomBar> {
  int currentIndex = 0;
  chooseBody() {
    if (currentIndex == 0) {
      return const CourseScreen(
          courseName: 'Current Order',
          courseInfo: 'Shubham Singh',
          coursePrice:
              '229/29 Street No. 8 Railway Colony Mandawali, New Delhi, Delhi 110092');
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
