import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hotelonwer/views/Screens/loginscrren/singup.dart';
import 'package:hotelonwer/resources/components/coustmfields/logout_information.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class Homepage extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    log('homepage');
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
              onPressed: () async {
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
                  Center(
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.transparent,
                      backgroundImage: currentUser?.photoURL != null
                          ? NetworkImage(currentUser!.photoURL!)
                          : AssetImage('lib/Asset/man.png') as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      currentUser?.displayName ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      currentUser?.email ?? 'No Email',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
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
              onTap: () async {
                await showLogoutConfirmationDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person_add_alt,
                color: Colors.red,
              ),
              title: const Text('Add Account'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 370,
                ),
                Text('Version 1.0.0'),
              ],
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('helloo'),
      ),
    );
  }
}
