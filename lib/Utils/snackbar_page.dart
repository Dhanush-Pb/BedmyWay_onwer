import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {Color? backgroundColor,
      double? fontSize,
      Color? textcolor,
      Duration? duration,
      FontWeight? fontWeight}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating, // Adjust behavior here
        margin: EdgeInsets.all(20.0), // Adjust margin here
        padding: EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 10.0), // Adjust padding here
        content: Container(
          height: 30,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: fontSize ?? 14.0,
                    color: textcolor,
                    fontWeight: fontWeight),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor ?? Colors.black87,
        duration: duration ?? Duration(seconds: 2),
      ),
    );
  }
}
