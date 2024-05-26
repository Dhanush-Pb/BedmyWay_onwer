import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/data_showing.dart';

import 'package:hotelonwer/views/Screens/loginscrren/loginpage.dart';

import 'package:hotelonwer/controller/bloc/auth_bloc.dart';

import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';

import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Datalisttpage();

    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacement(
            // ignore: prefer_const_constructors
            MaterialPageRoute(builder: (context) => BottomNavPage()),
          );
        } else if (state is UnAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Logingpage()),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'lib/Asset/Screenshot 2024-05-06 212614.png',
                      scale: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Lottie.asset('lib/Asset/Animation - 1715057009485.json',
                height: 100),
          ],
        ),
      ),
    );
  }

  void navigation(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Logingpage()),
      );
    });
  }

  void fetchdata() {
    context.read<HotelBloc>().add(FetchDataEvent());
  }
}
