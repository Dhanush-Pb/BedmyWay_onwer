import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';

import 'package:hotelonwer/views/Screens/loginscrren/singup.dart';

import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/google.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';
import 'package:lottie/lottie.dart';

class Logingpage extends StatefulWidget {
  const Logingpage({Key? key});

  @override
  State<Logingpage> createState() => _LogingpageState();
}

class _LogingpageState extends State<Logingpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(buildPageTransition(
                child:
                    BottomNavPage(), // Specify the page you want to navigate to
                curve: Curves.easeIn,
                axisDirection: AxisDirection.left,
              ));
            });
          } else if (state is AuthenticateError) {
            // Show Snackbar if authentication error occurs
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text(
                    'Invalid email or password',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w700),
                  ),
                  backgroundColor: Color.fromARGB(255, 180, 9, 9),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 15, left: 18, right: 18),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              );
            });
          } else if (state is Authloadin) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 300,
                    ),
                    Lottie.asset('lib/Asset/Animation - 1715182542819.json',
                        height: 150),
                    const SizedBox(
                      height: 35,
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(GoogleSignInEvent());
                        signInWithGoogle(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(10),
                          color: mycolor3,
                        ),
                        height: 45,
                        width: 350,
                        child: const Row(
                          children: [
                            SizedBox(
                              width: 45,
                            ),
                            CircleAvatar(
                              radius: 13,
                              backgroundColor: Color.fromARGB(0, 0, 0, 0),
                              backgroundImage:
                                  AssetImage('lib/Asset/300221.png'),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Continue with Google',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.mail_outline_outlined),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        errorText: _emailError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.visibility_off),
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0)),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0))),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        errorText: _passwordError,
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        // You can add more sophisticated password validation if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(Loginevent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ));
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 13, 53, 138),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignupPage()));
                        fetchdata();
                        // Navigate to sign-up page
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Do you have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Sign up',
                            style: TextStyle(
                                color: Color.fromARGB(255, 77, 175, 255)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void fetchdata() {
    context.read<HotelBloc>().add(FetchDataEvent());
  }
}
