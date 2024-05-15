import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hotelonwer/Screens/bottm_screens/splash_screen.dart';
import 'package:hotelonwer/bloc/auth_bloc.dart';
import 'package:hotelonwer/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Create an instance of checkloginevern event
        final checkLoginEvent = checkloginevern();
        // Dispatch the event to AuthBloc
        return AuthBloc()..add(checkLoginEvent);
      },
      child: MaterialApp(
        title: 'Hotel Owners',
        theme: ThemeData(),
        home: const Scaffold(
          body: SplashScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
