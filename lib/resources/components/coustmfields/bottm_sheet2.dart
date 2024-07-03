// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hotelonwer/Utils/snackbar_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/views/Screens/updationscreens/textfrom_updation.dart';

class HotelDetailsBottomSheet extends StatefulWidget {
  final String imagePath;
  final String hotelName;
  final String location;
  final String address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Map<String, dynamic> hotelData; // Change here

  const HotelDetailsBottomSheet({
    required this.imagePath,
    required this.hotelName,
    required this.location,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.hotelData, // Change here
  });

  @override
  State<HotelDetailsBottomSheet> createState() =>
      _HotelDetailsBottomSheetState();
}

class _HotelDetailsBottomSheetState extends State<HotelDetailsBottomSheet> {
  // Refresh function to be called after data is loaded
  void refreshFunction() {
    // print('Data has been refreshed');
    Navigator.of(context).pop();
  }

  // Method to show the delete confirmation dialog
  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button to dismiss the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: mycolor3,
          title: Text('Confirm Deletion', style: TextStyle(color: mycolor5)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete the hotel ${widget.hotelName} details?',
                  style: TextStyle(color: mycolor5),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: mycolor5)),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: mycolor5)),
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                widget.onDelete(); // Simulate data loading
                CustomSnackBar.show(
                    context, 'Hotel ${widget.hotelName} Details Deleted',
                    backgroundColor: mycolor4,
                    textcolor: mycolor8,
                    fontSize: 15,
                    fontWeight: FontWeight.w700);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.imagePath),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hotel Name: ${widget.hotelName}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Location: ${widget.location}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: mycolor3),
                    child: IconButton(
                        onPressed: () async {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => UpdateHoteldata(
                                  hotel: widget.hotelData), // Change here
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.edit_note_outlined,
                          size: 30,
                          color: mycolor4,
                        )),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(shape: BoxShape.circle, color: mycolor3),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showDeleteConfirmationDialog();
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          size: 30,
                          color: mycolor4,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showHotelDetailsBottomSheet(
  BuildContext context, {
  required String imagePath,
  required String hotelName,
  required String location,
  required String address,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
  required Map<String, dynamic> hotelData, // Change here
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return HotelDetailsBottomSheet(
          imagePath: imagePath,
          hotelName: hotelName,
          location: location,
          address: address,
          onEdit: onEdit,
          onDelete: onDelete,
          hotelData: hotelData); // Change here
    },
  );
}
