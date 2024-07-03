// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For accessing clipboard functionality
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
// Add this import for date formatting

class canceletails extends StatelessWidget {
  final String hotelName;
  final String bookingDate;
  final String checkInDate;
  final String checkOutDate;
  final double rating;
  final String roomType;
  final double totalAmount;
  final String location;
  final String contact;
  final String hotelId;
  final String payment;
  final String status;
  final String concelreson;
  //New field for Payment ID

  const canceletails({
    Key? key,
    required this.hotelName,
    required this.bookingDate,
    required this.checkInDate,
    required this.checkOutDate,
    required this.rating,
    required this.roomType,
    required this.totalAmount,
    required this.location,
    required this.contact,
    required this.hotelId,
    required this.payment,
    required this.status,
    required this.concelreson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor4,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Mycolor1,
        title: Text(
          'Cancel Hotel Info',
          style: TextStyle(
              color: mycolor4, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'lib/Asset/Screenshot 2024-06-21 115757.png',
                      width: 100,
                    ),
                    Text(
                      'This Hotel has been Cancelled',
                      style: TextStyle(color: Mycolor1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.050,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: shwdowcolor,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: mycolor4,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildRow('Hotel Name', hotelName),
                    buildRow('Booking Date', bookingDate),
                    buildRow('Check-In Date', checkInDate),
                    buildRow('Check-Out Date', checkOutDate),
                    buildRow('Rating', '$rating ⭐'),
                    buildRow('Room Type', roomType),
                    buildRow(
                        'Total Amount', '₹ ${totalAmount.toStringAsFixed(2)}'),
                    buildRow('Location', location),
                    buildRow('Contact', contact),
                    buildRow('Status', status),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: hotelId));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Copied $hotelId'),
                                    duration: Duration(
                                        seconds:
                                            1), // Adjust the duration as needed
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Booking Id',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        Text(
                          hotelId,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: hotelId));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Copied $payment'),
                                    duration: Duration(
                                        seconds:
                                            1), // Adjust the duration as needed
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'payment',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                        Text(
                          payment,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Reson of cancelation'),
                  Text(
                    concelreson,
                    style: TextStyle(fontSize: 16, color: Mycolor1),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(String heading, String data, [IconData? icondata]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              heading,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              data,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void showSnackbar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
