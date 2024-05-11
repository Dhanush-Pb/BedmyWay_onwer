import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/bloc/auth_bloc.dart';
import 'package:hotelonwer/coustmfields/textformfield.dart';
import 'package:lottie/lottie.dart';

class Passwordreset extends StatelessWidget {
  Passwordreset({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  // Function to validate email format using regular expression
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authloadin) {
            // Show loading indicator if the request is in progress
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color.fromARGB(255, 9, 126, 91),
                  content: Text('Loading...')),
            );
          } else if (state is AuthenticateError) {
            // Show error message if there is an authentication error
            Text(state.messege);
          } else if (state is AuthInitial) {
            // Show success message if password reset email sent successfully
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color.fromARGB(255, 9, 126, 91),
                  content: Text('Password reset email sent!')),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 55,
                ),
                Lottie.asset('lib/Asset/Animation - 1715323824477 (1).json',
                    width: 300),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  hintText: 'Enter email',
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    // Dispatch ForgotPasswordEvent with the entered email
                    final String email = emailController.text.trim();
                    if (email.isNotEmpty && isValidEmail(email)) {
                      context
                          .read<AuthBloc>()
                          .add(ForgotPasswordEvent(email: email));
                    } else {
                      // Show error message if email is empty or not valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 1),
                          content: Text('Please enter a valid email'),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 9, 126, 91),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restore,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Reset password',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
