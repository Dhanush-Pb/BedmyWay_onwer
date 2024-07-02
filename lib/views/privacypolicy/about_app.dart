import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to the BED MY WAY Hotel Owner App!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'This application is designed to help hotel owners manage their establishments efficiently. Whether you need to manage bookings, view guest details, or update your hotel information, our app provides you with the tools you need.',
            ),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('- Manage Bookings'),
            Text('- View Guest Information'),
            Text('- Update Hotel Details'),
            // Add more features as needed
            SizedBox(height: 20),
            Text(
              'We are committed to providing you with a user-friendly and reliable experience. If you have any feedback or suggestions, please feel free to contact us.',
            ),
          ],
        ),
      ),
    );
  }
}
