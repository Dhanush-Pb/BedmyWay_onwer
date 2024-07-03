// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:hotelonwer/views/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';

Future<void> signInWithGoogle(BuildContext context) async {
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      //   print("User canceled sign-in");
      return;
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user == null) {
      return;
    }

    if (userCredential.user != null) {
      Navigator.of(context).pushReplacement(buildPageTransition(
          child: BottomNavPage(),
          curve: Curves.easeIn,
          axisDirection: AxisDirection.left));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Logingpage()),
      );
    }
  } catch (error) {
    // print("Error signing in with Google: $error");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Logingpage()),
    );
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();

    await GoogleSignIn().signOut();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Logingpage()),
      (Route<dynamic> route) => false,
    );
  } catch (error) {
    // ignore: avoid_print
    print("Error signing out: $error");
  }
}
