import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/controller/revnue/bloc/revanue_bloc.dart';

import 'package:hotelonwer/views/Screens/bottm_screens/data_showing.dart';
import 'package:hotelonwer/views/Screens/loginscrren/singup.dart';
import 'package:hotelonwer/resources/components/coustmfields/logout_information.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:fl_chart/fl_chart.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? currentUser;

  @override
  void initState() {
    context.read<RevanueBloc>().add(Revenuefetch());
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    Datalisttpage();
    fetchdata();
  }

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
                Icons.menu,
                color: mycolor3,
                size: 27,
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
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          int currentHotels = 0;
          int bookedHotels = 0;

          if (state is HotelDataFetched) {
            currentHotels = state.Hotels.length;
            bookedHotels = 2;
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 1,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Hotel status',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booked Hotels: ${bookedHotels.toString()}',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Current Hotels: ${currentHotels.toString()}',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: (currentHotels == 0 && bookedHotels == 0)
                            ? Image.asset(
                                'lib/Asset/Screenshot 2024-06-03 174044.png',
                                width: 200,
                              )
                            : PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color:
                                          const Color.fromARGB(255, 6, 88, 156),
                                      value: bookedHotels.toDouble(),
                                      radius: 45,
                                    ),
                                    PieChartSectionData(
                                      color: Color.fromARGB(255, 196, 24, 12),
                                      value: currentHotels.toDouble(),
                                      radius: 45,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void fetchdata() {
    context.read<HotelBloc>().add(FetchDataEvent());
    context.read<RevanueBloc>().add(Revenuefetch());
  }
}
