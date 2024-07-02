import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'Last updated: 01-07-2024',
              style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20),
            Text(
              'Introduction:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to the BED MY WAY Hotel Owner App Privacy Policy. We are committed to protecting your privacy. This policy explains how we collect, use, and safeguard your information as a hotel owner using our application.',
            ),
            SizedBox(height: 20),
            Text(
              'Data Collection and Usage:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'We collect information such as your name, email address, hotel details, and other relevant information to provide and improve our services to you. This includes managing bookings, guest information, and operational data.',
            ),
            SizedBox(height: 20),
            Text(
              'Security Measures:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'We implement industry-standard security measures to protect your information from unauthorized access, disclosure, or alteration.',
            ),
            SizedBox(height: 20),
            Text(
              'Contact Us:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'If you have any questions about our Privacy Policy, please contact us at dhanushpb49@gmail.com.',
            ),
          ],
        ),
      ),
    );
  }
}
