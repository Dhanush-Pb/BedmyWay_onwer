import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotelonwer/Screens/singup.dart';
import 'package:hotelonwer/bloc/auth_bloc.dart';
import 'package:hotelonwer/coustmfields/Bottm.dart';
import 'package:hotelonwer/coustmfields/google.dart';
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BottomNavPage()));
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
                  backgroundColor: Color.fromARGB(255, 241, 23, 23),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 675, left: 18, right: 18),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              );
            });
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
                      height: 220,
                    ),
                    Lottie.asset('lib/Asset/Animation - 1715182542819.json',
                        width: 250),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        signInWithGoogle(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: .5),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 255, 255, 255),
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
                              backgroundColor: Color.fromARGB(0, 90, 81, 81),
                              backgroundImage:
                                  AssetImage('lib/Asset/300221.png'),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Continue With Google',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 235, 17, 17)),
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
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
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
                        // You can add more sophisticated email validation if needed
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Dispatch login event with email and password
                          BlocProvider.of<AuthBloc>(context).add(Loginevent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          ));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 235, 17, 17)),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(150.0, 35.0)),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Singuppage()));
                        // Navigate to sign-up page
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.black),
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
}
