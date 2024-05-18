import 'package:flutter/material.dart';

import 'package:hotelonwer/views/Screens/bottm_screens/add_details.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/data_showing.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/home_page.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/messege_screen.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

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
        backgroundColor: mycolor5,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: mycolor3,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              tabs: const [
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
              indicatorColor: Mycolor1, // Change the color of the indicator
              labelColor:
                  Colors.white, // Change the color of the selected tab label
              unselectedLabelColor: Color.fromARGB(255, 179, 178,
                  178), // Change the color of unselected tab labels
            ),
          ),
        ),
        body: const TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Homepage(),
            Datalisttpage(),
            Adddatapage(),
            Messegepage(),
          ],
        ),
      ),
    );
  }
}
