// ignore_for_file: use_key_in_widget_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_event.dart';
import 'package:hotelonwer/controller/revnue/bloc/revanue_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/network_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/tabbar_view2.dart';
import 'package:hotelonwer/resources/components/tabbar_view.dart';
import 'package:hotelonwer/views/Screens/loginscrren/singup.dart';
import 'package:hotelonwer/resources/components/coustmfields/logout_information.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/views/privacypolicy/about_app.dart';
import 'package:hotelonwer/views/privacypolicy/help_line.dart';
import 'package:hotelonwer/views/privacypolicy/privacy_policy.dart';
import 'package:hotelonwer/views/privacypolicy/terms_conditon.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  User? currentUser;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchdata();
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    InternetConnectionChecker.start(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Tabview2()));
              },
              icon: Icon(Icons.business_rounded))
        ],
        backgroundColor: Colors.transparent,
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
        backgroundColor: mycolor4,
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
                        color: mycolor4,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      currentUser?.email ?? 'No Email',
                      style: TextStyle(
                        color: mycolor4,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.person_add_alt,
                color: mycolor8,
              ),
              title: const Text('Add Account'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignupPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.privacy_tip_sharp,
                color: mycolor8,
              ),
              title: const Text('Privacy Policy'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PrivacyPolicyPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.details,
                color: mycolor8,
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.help,
                color: mycolor8,
              ),
              title: const Text('Help line'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HelpLinePage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.description,
                color: mycolor8,
              ),
              title: const Text('Terms & condition'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditionsPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: mycolor8,
              ),
              title: const Text('Logout'),
              onTap: () {
                showLogoutConfirmationDialog(context);
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 370,
                ),
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: mycolor8),
                ),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: mycolor8, // Replace with your color variable
        onRefresh: () async {
          await fetchdata();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              BlocBuilder<HotelBloc, HotelState>(
                builder: (context, hotelState) {
                  int currentHotels = 0;
                  int bookedHotels = 0;
                  double totalRevenue = 0.0;

                  if (hotelState is HotelDataFetched) {
                    currentHotels = hotelState.Hotels.length;
                  } else if (hotelState is Hoteldataloading) {
                    return Center(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        CircularProgressIndicator(
                          color: mycolor8,
                        )
                      ]),
                    );
                  }

                  return BlocBuilder<RevanueBloc, RevanueState>(
                    builder: (context, revenueState) {
                      if (revenueState is BookedDatafetched) {
                        final bookedHotelsList = revenueState.hotels
                            .where((hotel) => hotel['staus'] == 'Booked')
                            .toList();

                        bookedHotels = bookedHotelsList.length;

                        totalRevenue = revenueState.hotels.fold(
                          0.0,
                          (sum, hotel) {
                            if (hotel['payment'] != 'Pay at Hotel') {
                              return sum +
                                  (double.tryParse(hotel['TotalAmount']) ??
                                      0.0);
                            } else {
                              return sum;
                            }
                          },
                        );
                      } else if (revenueState is Bookdataloading) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                              ),
                              CircularProgressIndicator(
                                color: mycolor8,
                              )
                            ],
                          ),
                        );
                      }

                      return Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Container(
                          height: 360,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: mycolor4,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(92, 117, 117, 117)
                                    .withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
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
                                  color: mycolor8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Booked Rooms: ${bookedHotels.toString()}',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Available Hotels: ${currentHotels.toString()}',
                                    style: TextStyle(
                                      color: Mycolor1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Expanded(
                                child: (currentHotels == 0 && bookedHotels == 0)
                                    ? Image.asset(
                                        'lib/Asset/Screenshot 2024-06-20 195158.png',
                                        width: 200,
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            children: [
                                              CircularPercentIndicator(
                                                animationDuration: 700,
                                                curve: Curves.linear,
                                                startAngle: 5,
                                                animation: true,
                                                radius: 70.0,
                                                lineWidth: 15.0,
                                                percent: bookedHotels /
                                                    (bookedHotels +
                                                            currentHotels)
                                                        .toDouble(),
                                                center: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Booked Rooms',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mycolor8,
                                                      ),
                                                    ),
                                                    Text(
                                                      bookedHotels.toString(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: mycolor8,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                progressColor: Colors.blue,
                                                backgroundColor: mycolor5,
                                                circularStrokeCap:
                                                    CircularStrokeCap.round,
                                              ),
                                              Expanded(
                                                child: CircularPercentIndicator(
                                                  animationDuration: 700,
                                                  curve: Curves.linear,
                                                  startAngle: 5,
                                                  animation: true,
                                                  radius: 70.0,
                                                  lineWidth: 15.0,
                                                  percent: currentHotels /
                                                      (bookedHotels +
                                                              currentHotels)
                                                          .toDouble(),
                                                  center: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Available Hotels',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: mycolor8,
                                                        ),
                                                      ),
                                                      Text(
                                                        currentHotels
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: mycolor8,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  progressColor: Mycolor1,
                                                  backgroundColor: mycolor5,
                                                  circularStrokeCap:
                                                      CircularStrokeCap.round,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 40),
                                          Text(
                                            'Total Revenue: ₹ ${totalRevenue.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: mycolor8,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: TabbarView(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0, right: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  0.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: mycolor5,
              mini: true,
              heroTag: 'scrollToTop',
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Mycolor1,
                size: 20,
              ),
            ),
            SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              backgroundColor: mycolor5,
              mini: true,
              heroTag: 'scrollToBottom',
              child: Icon(
                Icons.arrow_downward_rounded,
                color: Mycolor1,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchdata() async {
    context.read<HotelBloc>().add(FetchDataEvent());
    context.read<RevanueBloc>().add(Revenuefetch());
    context.read<FetchMsgsBloc>().add(fetchmessages());
  }
}
