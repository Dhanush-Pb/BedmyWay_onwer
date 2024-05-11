import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Screens/loginscrren/loginpage.dart';
import 'package:hotelonwer/Screens/loginscrren/singup.dart';
import 'package:hotelonwer/bloc/auth_bloc.dart';
import 'package:hotelonwer/coustmfields/google.dart';
import 'package:hotelonwer/coustmfields/transitrion.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Color.fromARGB(255, 255, 0, 0),
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            // If the user is authenticated, fetch user data and display the name
            final authBloc = BlocProvider.of<AuthBloc>(context);
            authBloc.add(FetchDataEvent()); // Fetch user data
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is UserDataLoadedgeted) {
                  // Once user data is loaded, display the name in the drawer header
                  return Drawer(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Text(
                            'Hello, ${state.user.name}', // Display user's name here
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 0, 0)),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text('Logout'),
                          onTap: () {
                            _showLogoutConfirmationDialog(context);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.person_add_alt),
                          title: const Text('Add Account'),
                          onTap: () {
                            // Navigate to settings page
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    SignupPage())); // Close the drawer
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
                        // Add more ListTile widgets for additional options
                      ],
                    ),
                  );
                } else {
                  // Show loading indicator while fetching user data
                  return const Drawer(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          } else {
            // If the user is not authenticated, show default drawer
            return Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Text(
                      'Hello gesut',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      _showLogoutConfirmationDialog(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add_alt),
                    title: const Text('Add Account'),
                    onTap: () {
                      // Navigate to settings page
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SignupPage())); // Close the drawer
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
                  // Add more ListTile widgets for additional options
                ],
              ),
            );
          }
        },
      ),
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                final authBloc = BlocProvider.of<AuthBloc>(context);
                authBloc.add(logoutevent());
                signOut(context);
                Navigator.of(context).pushAndRemoveUntil(
                  buildPageTransition(
                    child: Logingpage(),
                    curve: Curves.easeIn,
                    axisDirection: AxisDirection.right,
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
