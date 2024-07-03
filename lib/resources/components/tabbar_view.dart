import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/revnue/bloc/revanue_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/views/Screens/booking_details/booking_details.dart';
import 'package:hotelonwer/views/Screens/booking_details/cancel_detils.dart';
import 'package:intl/intl.dart';

class TabbarView extends StatefulWidget {
  const TabbarView({Key? key}) : super(key: key);

  @override
  State<TabbarView> createState() => _TabbarViewState();
}

class _TabbarViewState extends State<TabbarView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: mycolor5,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Discover Your Hotel Details',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            backgroundColor: mycolor4,
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Booked hotels'),
                Tab(text: 'Cancelled hotels'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildTabContent(context, 'Booked'),
              _buildTabContent(context, 'Cancelled'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String status) {
    Color statusColor = mycolor8;
    if (status == 'Booked') {
      statusColor = mygreen;
    } else if (status == 'Cancelled') {
      statusColor = Mycolor1;
    }
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: mycolor4,
      constraints: BoxConstraints.expand(),
      child: BlocBuilder<RevanueBloc, RevanueState>(
        builder: (context, state) {
          if (state is Bookdataloading) {
            return Center(
                child: CircularProgressIndicator(
              color: mycolor8,
            ));
          }
          if (state is BookedDatafetched) {
            if (state.hotels.isEmpty) {
              return Center(
                child: Text('No data'),
              );
            }
            final hotels = state.hotels
                .where((hotel) => hotel['staus'] == status)
                .toList();
            if (hotels.isEmpty) {
              return Center(
                child: Text(status == 'Booked'
                    ? 'No booked hotels found.'
                    : 'No cancelled hotels found.'),
              );
            }
            hotels.sort((a, b) {
              DateTime dateA =
                  DateFormat('yyyy-MMMM-dd – hh:mm a').parse(a['bookeddate']);
              DateTime dateB =
                  DateFormat('yyyy-MMMM-dd – hh:mm a').parse(b['bookeddate']);
              return dateB.compareTo(dateA);
            });

            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                final booking = hotels[index];

                final bookingDate = (booking['bookeddate'].toString());

                final rating =
                    double.tryParse(booking['Rating'].toString()) ?? 0.0;
                final totalAmount =
                    double.tryParse(booking['TotalAmount'].toString()) ?? 0.0;
                String formattedCheckInDate =
                    booking['checkInDate']?.toDate() != null
                        ? DateFormat('dd/MMMM/yyyy')
                            .format(booking['checkInDate'].toDate())
                        : 'Check-In Date';

                String formattedCheckOutDate =
                    booking['checkOutDate']?.toDate() != null
                        ? DateFormat('dd/MMMM/yyyy')
                            .format(booking['checkOutDate'].toDate())
                        : 'Check-Out Date';

                return InkWell(
                  onTap: () {
                    if (status == 'Booked') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Bookedetails(
                            hotelName: booking['Hotalnmae'],
                            bookingDate: bookingDate,
                            checkInDate: formattedCheckInDate,
                            checkOutDate: formattedCheckOutDate,
                            rating: rating,
                            roomType: booking['Room'],
                            totalAmount: totalAmount,
                            location: booking['Location'],
                            contact: booking['contact'],
                            hotelId: booking['hotelDocId'],
                            payment: booking['payment'],
                            status: booking['staus'],
                          ),
                        ),
                      );
                    } else if (status == 'Cancelled') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => canceletails(
                            hotelName: booking['Hotalnmae'],
                            bookingDate: bookingDate,
                            checkInDate: formattedCheckInDate,
                            checkOutDate: formattedCheckOutDate,
                            rating: rating,
                            roomType: booking['Room'],
                            totalAmount: totalAmount,
                            location: booking['Location'],
                            contact: booking['contact'],
                            hotelId: booking['hotelDocId'],
                            payment: booking['payment'],
                            status: booking['staus'],
                            concelreson: booking['Cancelreson'],
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bookingDate,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Status',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      booking['staus'],
                                      style: TextStyle(color: statusColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text('Hotel: ${booking['Hotalnmae']}'),
                      SizedBox(height: 5),
                      Text('Location: ${booking['Location']}'),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Image.asset(
              'lib/Asset/Screenshot 2024-06-20 195158.png',
              width: 130,
            ));
          }
        },
      ),
    );
  }
}
