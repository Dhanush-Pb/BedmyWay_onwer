import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_bloc.dart';
import 'package:hotelonwer/controller/fetchmsg/bloc/fetch_msgs_event.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/add_details.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/data_showing.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/home_page.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/messege_screen.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavPage extends StatefulWidget {
  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Homepage(),
    Datalisttpage(),
    Adddatapage(),
    Messegepage(),
  ];

  @override
  void initState() {
    context.read<FetchMsgsBloc>().add(fetchmessages());
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(35),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          child: GNav(
            gap: 8,
            activeColor: mycolor4,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            duration: const Duration(milliseconds: 800),
            tabBackgroundColor: Color.fromARGB(195, 230, 12, 12),
            color: Colors.black,
            tabs: const [
              GButton(
                icon: Icons.house,
                iconSize: 18,
                text: 'Home',
              ),
              GButton(
                icon: Icons.menu,
                iconSize: 22,
                text: 'Details',
              ),
              GButton(
                icon: Icons.add,
                iconSize: 19,
                text: 'Add Hotel',
              ),
              GButton(
                icon: Icons.message,
                text: 'Message',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  void fetchdata() {
    context.read<HotelBloc>().add(FetchDataEvent());
  }
}
