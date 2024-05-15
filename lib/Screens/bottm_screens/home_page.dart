import 'package:flutter/material.dart';

import 'package:hotelonwer/Screens/loginscrren/singup.dart';
import 'package:hotelonwer/coustmfields/logout_information.dart';
import 'package:hotelonwer/coustmfields/theame.dart';

class Homepage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        backgroundColor: mycolor5,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: Mycolor1,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 44, 59, 87),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 90),
                        child: Image.asset(
                          'lib/Asset/chat.png',
                          scale: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 70),
                    child: Image.asset(
                      'lib/Asset/man.png',
                      height: 90,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text('Logout'),
              onTap: () {
                showLogoutConfirmationDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add_alt,
                color: Colors.red,
              ),
              title: const Text('Add Account'),
              onTap: () {
                // Navigate to settings page
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupPage())); // Close the drawer
              },
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 370,
                ),
                Text('Version 1.0.0')
              ],
            )
          ],
        ),
      ),
      body: const Center(
        child: Text('helloo'),
      ),
    );
  }
}
