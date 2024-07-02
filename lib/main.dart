import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_bloc.dart';
import 'package:hotelonwer/controller/msgbloc/bloc/scoketmsg_bloc.dart';
import 'package:hotelonwer/controller/revnue/bloc/revanue_bloc.dart';
import 'package:hotelonwer/repositoires/message_repository.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/splash_screen.dart';
import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageRepository = MessageRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) {
            final checkLoginEvent = checkloginevern();
            return AuthBloc()..add(checkLoginEvent);
          },
        ),
        BlocProvider<RevanueBloc>(create: (context) => RevanueBloc()),
        BlocProvider<FetchMsgsBloc>(create: (context) => FetchMsgsBloc()),
        BlocProvider<HotelBloc>(create: (context) => HotelBloc()),
        BlocProvider<ScoketmsgBloc>(
          create: (context) =>
              ScoketmsgBloc(messageRepository: messageRepository),
        ),
      ],
      child: MaterialApp(
        title: 'BedMyWay',
        theme: ThemeData(),
        home: const Scaffold(
          body: SplashScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
