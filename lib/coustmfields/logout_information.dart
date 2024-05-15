import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/bloc/auth_bloc.dart';
import 'package:hotelonwer/coustmfields/google.dart';
import 'package:hotelonwer/coustmfields/transitrion.dart';

showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              final authBloc = BlocProvider.of<AuthBloc>(context);
              authBloc.add(logoutevent());
              signOut(context);
              Navigator.of(context).pushAndRemoveUntil(
                buildPageTransition(
                  // ignore: prefer_const_constructors
                  child: Logingpage(),
                  curve: Curves.easeIn,
                  axisDirection: AxisDirection.right,
                ),
                (Route<dynamic> route) => false,
              );
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  );
}
