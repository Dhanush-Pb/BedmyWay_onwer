import 'package:flutter/material.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class CustomErrorDialog extends StatelessWidget {
  final String message;

  const CustomErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Image.asset(
            'lib/Asset/techny-data-dashboard-with-charts-and-graphs.gif',
            width: 200,
          ),
        ],
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Mycolor1),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  static void show(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CustomErrorDialog(message: message);
      },
    );
  }
}
