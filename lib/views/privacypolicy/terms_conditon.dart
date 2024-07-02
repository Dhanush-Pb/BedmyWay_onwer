import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'Last updated: 01-07-2024',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introduction',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to the BED MY WAY Hotel Owner App. These terms and conditions outline the rules and regulations for the use of our application.',
            ),
            SizedBox(height: 20),
            Text(
              '2. Acceptance of Terms',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'By accessing or using our application, you agree to be bound by these terms and conditions. If you do not agree with any part of these terms, you may not use our services.',
            ),
            SizedBox(height: 20),
            Text(
              '3. User Responsibilities',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'You are responsible for maintaining the confidentiality of your account and password. You agree to provide accurate and complete information when using our services.',
            ),
            SizedBox(height: 20),
            Text(
              '4. Limitation of Liability',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'We are not liable for any direct, indirect, incidental, special, or consequential damages that result from the use or inability to use our application.',
            ),
            SizedBox(height: 20),
            Text(
              '5. Contact Us',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have any questions about these terms and conditions, please contact us at [Your Contact Email].',
            ),
          ],
        ),
      ),
    );
  }
}
