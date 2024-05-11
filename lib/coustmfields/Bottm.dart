import 'package:flutter/material.dart';
import 'package:hotelonwer/Screens/add_details.dart';
import 'package:hotelonwer/Screens/datashowing.dart';
import 'package:hotelonwer/Screens/homepage.dart';
import 'package:hotelonwer/Screens/messege.dart';

class BottomNavPage extends StatefulWidget {
  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.home,
                  size: 28,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.view_list,
                  size: 28,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.add_box,
                  size: 28,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.message,
                  size: 28,
                ),
              )
            ],
            indicatorColor: Color.fromARGB(255, 146, 1, 1),
            labelColor: Color.fromARGB(255, 223, 2, 2),
          ),
        ),
        body: const TabBarView(children: [
          Homepage(),
          Datalisttpage(),
          Adddatapage(),
          Messegepage()
        ]),
      ),
    );
  }
}
