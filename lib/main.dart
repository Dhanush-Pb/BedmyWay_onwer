import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hotelonwer/views/Screens/bottm_screens/splash_screen.dart';

import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
// Import your HotelBloc
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            // Create an instance of checkloginevern event
            final checkLoginEvent = checkloginevern();
            // Dispatch the event to AuthBloc
            return AuthBloc()..add(checkLoginEvent);
          },
        ),
        BlocProvider<HotelBloc>(create: (context) => HotelBloc()),
      ],
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
