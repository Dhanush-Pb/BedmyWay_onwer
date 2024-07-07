// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/google.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';
import 'package:hotelonwer/views/Screens/loginscrren/loginpage.dart';

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
            onPressed: () async {
              final authBloc = BlocProvider.of<AuthBloc>(context);
              signOut(context);
              authBloc.add(logoutevent());
              authBloc.add(GoogleSignOutEvent());
              await Future.delayed(Duration(milliseconds: 500));
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
            child: Text(
              'Logout',
              style: TextStyle(color: Mycolor1),
            ),
          ),
        ],
      );
    },
  );
}
