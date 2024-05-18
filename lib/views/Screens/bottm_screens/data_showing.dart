import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class Datalisttpage extends StatefulWidget {
  const Datalisttpage({Key? key}) : super(key: key);

  @override
  State<Datalisttpage> createState() => _DatalisttpageState();
}

class _DatalisttpageState extends State<Datalisttpage> {
  @override
  void initState() {
    super.initState();
    context.read<HotelBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    log('it is details page');
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Hotels',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mycolor3,
      ),
      body: BlocConsumer<HotelBloc, HotelState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is Hoteldataloading) {
            log('cir');
            return Center(child: CircularProgressIndicator());
          } else if (state is HotelDataFetched) {
            return ListView.builder(
              itemCount: state.Hotels.length,
              itemBuilder: (context, index) {
                final hotel = state.Hotels[index];
                List<String> pathImageUrls = [];

                // Check if pathimage is a List<dynamic>
                if (hotel['coverimage'] is List<dynamic>) {
                  // Cast each item to String and add to pathImageUrls
                  pathImageUrls =
                      (hotel['coverimage'] as List<dynamic>).map((item) {
                    if (item is String) {
                      return item;
                    } else {
                      return '';
                    }
                  }).toList();
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      for (final imageUrl in pathImageUrls)
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 25, right: 20, left: 20),
                          child: Container(
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(2)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 4,
                                  blurRadius: 6,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                        topLeft: Radius.circular(2)),
                                    child: Image.network(
                                      imageUrl,
                                      width: 120,
                                      height: 110,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Text(
                                      hotel['name'] ?? '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Mycolor1,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              minWidth:
                                                  0, // Allow minimum width
                                            ),
                                            child: Text('${hotel['locaton']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: const Color.fromARGB(
                                                      255, 80, 80, 80),
                                                ),
                                                maxLines:
                                                    1, // Maximum of one line
                                                overflow: TextOverflow
                                                    .clip // Ensure minimum of one line
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            );
          } else if (state is HotelDataError) {
            log('data not geted');
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
