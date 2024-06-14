import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Utils/snackbar_page.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';

import 'package:hotelonwer/resources/components/coustmfields/dropdown_button.dart';
import 'package:hotelonwer/resources/components/coustmfields/text_formfield2.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

import 'package:hotelonwer/views/Screens/imagescreens/hotel_photos.dart';
import 'package:hotelonwer/views/Screens/imagescreens/tour_photo.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class UpdateHoteldata extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const UpdateHoteldata({Key? key, required this.hotel}) : super(key: key);

  @override
  State<UpdateHoteldata> createState() => _UpdateHoteldataState();
}

class _UpdateHoteldataState extends State<UpdateHoteldata> {
  String? selectedWifiAvailability;
  String? selectedFoodAvailability;
  String? refundOption;
  String? roomType;
  String? acoption;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController inceptionYearController = TextEditingController();
  final TextEditingController touristPlacesController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  bool _showCircleAvatar = false; // Declare the flag here
  bool _istaped = true;
  @override
  void initState() {
    super.initState();

    hotelNameController.text = widget.hotel['name'] ?? '';
    descriptionController.text = widget.hotel['description'] ?? '';
    priceController.text = widget.hotel['price'].toString();
    locationController.text = widget.hotel['locaton'] ?? '';
    inceptionYearController.text = widget.hotel['sinceYear'].toString();
    touristPlacesController.text = widget.hotel['touristlocaton'] ?? '';
    contactController.text = widget.hotel['contact'] ?? '';
    selectedWifiAvailability = widget.hotel['wifi'];
    selectedFoodAvailability = widget.hotel['foodoption'];
    refundOption = widget.hotel['Refundoption'];
    roomType = widget.hotel['Room'];
    acoption = widget.hotel['acoption'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Update details',
          style: TextStyle(
              color: mycolor5, fontSize: 15, fontWeight: FontWeight.w600),
        ),
        backgroundColor: mycolor3,
        leading: IconButton(
          onPressed: () {
            setState(() {
              _showCircleAvatar =
                  !_showCircleAvatar; // Correctly toggle visibility
              _istaped = !_istaped; // Correctly toggle the flag
            });
          },
          icon: _istaped
              ? Icon(Icons
                  .photo_library_outlined) // Display photo library icon if _istaped is true
              : Icon(Icons.arrow_back), // Otherwise, display arrow back icon
          color: Colors.white, // Assuming mycolor4 is white for simplicity
        ),
      ),
      backgroundColor: mycolor5,
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Form(
              key: _formKey,
              child: BlocBuilder<HotelBloc, HotelState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      CustomTextField2(
                        fillColor: mycolor4,
                        keyboardType: TextInputType.name,
                        controller: hotelNameController,
                        hintText: 'Enter your hotel name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter hotel name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField2(
                        fillColor: mycolor4,
                        keyboardType: TextInputType.multiline,
                        controller: descriptionController,
                        // maxLines: 3,
                        hintText: 'Enter hotel description',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter hotel description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomDropdownButton<String>(
                              hintText: 'Wifi option',
                              value: selectedWifiAvailability,
                              items: const [
                                'Available',
                                'Not Available',
                                'Limited'
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedWifiAvailability = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select wifi availability';
                                }
                                return null;
                              },
                              dropdownStyle:
                                  const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomDropdownButton<String>(
                              hintText: 'Room type',
                              value: roomType,
                              items: const [
                                'Single room',
                                'Double room',
                                'Deluxe room',
                                'Studio room'
                              ],
                              onChanged: (value) {
                                setState(() {
                                  roomType = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select the room type';
                                }
                                return null;
                              },
                              dropdownStyle:
                                  const TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField2(
                        fillColor: mycolor4,
                        keyboardType: TextInputType.name,
                        controller: inceptionYearController,
                        hintText: 'Adress&landmark',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Details';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField2(
                              maxlength: 20,
                              fillColor: mycolor4,
                              keyboardType: TextInputType.text,
                              controller: locationController,
                              hintText: 'Enter location',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter location';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: CustomTextField2(
                              fillColor: mycolor4,
                              keyboardType: TextInputType.number,
                              controller: priceController,
                              hintText: 'Enter price',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter price';
                                }
                                return null;
                              },
                            ),
                            // child:
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField2(
                        fillColor: mycolor4,
                        keyboardType: TextInputType.multiline,
                        controller: touristPlacesController,
                        hintText: 'Enter nearest tourist places',
                        // maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter tourist places';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      IntlPhoneField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Phone',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: mycolor3),
                          ),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                        controller: contactController,
                        initialCountryCode: 'IN', // Initial country code
                        validator: (value) {
                          if (value == null) {
                            return 'Phone is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomDropdownButton<String>(
                        hintText: 'Food option',
                        value: acoption,
                        items: const ['Available', 'Non A/C'],
                        onChanged: (value) {
                          setState(() {
                            acoption = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select AC availability';
                          }
                          return null;
                        },
                        dropdownStyle: const TextStyle(color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: CustomDropdownButton<String>(
                              hintText: 'Food option',
                              value: selectedFoodAvailability,
                              items: const ['Free food', 'Paid'],
                              onChanged: (value) {
                                setState(() {
                                  selectedFoodAvailability = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select food availability';
                                }
                                return null;
                              },
                              dropdownStyle:
                                  const TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomDropdownButton<String>(
                              hintText: 'Refund option',
                              value: refundOption,
                              items: const ['Yes', 'No', '50%'],
                              onChanged: (value) {
                                setState(() {
                                  refundOption = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select refund option';
                                }
                                return null;
                              },
                              dropdownStyle:
                                  const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: _updateHotel,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 13, 52, 160),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            textStyle: const TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 15,
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          if (_showCircleAvatar) // Conditional rendering based on flag
            Positioned(
              top: 180, // Adjust position as needed
              left: 50, // Adjust position as needed
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(0.4)),

                    // Example background color
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Hotelroomreplce(
                                      roomImages: widget.hotel['images'],
                                      documntid: widget.hotel['id'],
                                    )));
                            log(widget.hotel['id']);
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.restore_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Replace your Room images',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            log(widget.hotel['id']);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TouristImageReplace(
                                      touristImages: widget.hotel['tourimage'],
                                      documentId: widget.hotel['id'],
                                      coverimage: widget.hotel['coverimage'],
                                      pathimage: widget.hotel['pathimage'],
                                    )));
                          },
                          child: Container(
                            height: 50,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.restore_outlined),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Replace your Tourist images',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
        ],
      ),
    );
  }

  void _updateHotel() {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': hotelNameController.text.trim(),
        'description': descriptionController.text.trim(),
        'price': priceController.text.toString().trim(),
        'locaton': locationController.text.trim(),
        'sinceYear': inceptionYearController.text.toString().trim(),
        'touristlocaton': touristPlacesController.text.trim(),
        'foodoption': selectedFoodAvailability,
        'Refundoption': refundOption,
        'wifi': selectedWifiAvailability,
        'contact': contactController.text.toString().trim(),
        'Room': roomType,
        'acoption': acoption,
      };

      context
          .read<HotelBloc>()
          .add(UpdateHotelData(data, id: widget.hotel['id']));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => BottomNavPage()),
          (route) => false);
      CustomSnackBar.show(
          context, 'Hotel ${widget.hotel['name']} Details Updated',
          backgroundColor: mycolor4,
          textcolor: mycolor8,
          fontSize: 15,
          fontWeight: FontWeight.w700);
    }
  }
}
