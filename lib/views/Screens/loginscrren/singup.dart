import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/home_page.dart';
import 'package:hotelonwer/views/Screens/loginscrren/passwordreset.dart';

import 'package:hotelonwer/controller/bloc/auth_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/textformfield.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';
import 'package:hotelonwer/model/user_model.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _navigateToBottomNavPage(context);
            } else if (state is AuthenticateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Mycolor1,
                  content: Text(
                      "The email address is already in use by another account."),
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          'lib/Asset/Animation - 1715324877782 (1).json',
                          width: 200,
                        ),
                        const Text(
                          'Register With Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 35),
                        CustomTextField(
                          keyboardType: TextInputType.emailAddress,
                          hintText: 'Enter Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            } else if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          keyboardType: TextInputType.visiblePassword,
                          hintText: 'Password',
                          controller: passwordController,
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            } else if (value.length < 7) {
                              return 'Password must be at least 7 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          hintText: 'Name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // Replace CustomTextField with IntlPhoneField
                        IntlPhoneField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: mycolor4,
                            labelText: 'Phone',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          controller: phoneController,
                          initialCountryCode: 'IN', // Initial country code
                          validator: (value) {
                            if (value == null) {
                              return 'Phone is required';
                            }
                            // Additional validation can be added here if needed
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Usermodel user = Usermodel(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                              final authBloc =
                                  BlocProvider.of<AuthBloc>(context);
                              authBloc.add(singupevent(user, usermodel: user));
                            }
                            const Homepage();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 235, 17, 17),
                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(150.0, 35.0),
                            ),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(color: mycolor4),
                          ),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Passwordreset()));
                          },
                          child: const Text('Forget Password ? '),
                        ),
                        const SizedBox(height: 15),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Already have an Account?  Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToBottomNavPage(BuildContext context) async {
    await Navigator.of(context).pushReplacement(buildPageTransition(
        child: BottomNavPage(),
        curve: Curves.easeIn,
        axisDirection: AxisDirection.left));
  }
}
