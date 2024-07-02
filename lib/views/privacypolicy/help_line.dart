import 'package:flutter/material.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class HelpLinePage extends StatelessWidget {
  const HelpLinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Line'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help Line',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 10),
            Text(
              'For assistance with the BED MY WAY Hotel Owner App, please contact our support team via:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email Support'),
              subtitle: Text(
                'dhanushpb49@gmail.com',
                style: TextStyle(color: myblue),
              ),
              onTap: () {
                // Implement email functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Phone Support'),
              subtitle: Text(
                '9947191878',
                style: TextStyle(color: myblue),
              ),
              onTap: () {
                // Implement phone call functionality
              },
            ),
            SizedBox(height: 20),
            Text(
              'Our support team is available 10 AM to 5 PM  to assist you.',
            ),
          ],
        ),
      ),
    );
  }
}
