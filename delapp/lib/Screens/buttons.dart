import 'package:flutter/material.dart';

class DeliveredButton extends StatelessWidget {
  final String title;
  final String subText;
  final Function() onPressed;
  const DeliveredButton(
      {required this.title,
      required this.onPressed,
      this.subText = "",
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      child: InkWell(
        onTap: onPressed,
        // ignore: prefer_const_constructors
        splashColor: Color.fromARGB(255, 231, 160, 5),
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 75,
          // padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.amber[800],
              borderRadius: BorderRadius.circular(25.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
