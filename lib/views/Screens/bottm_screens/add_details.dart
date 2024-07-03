// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';

import 'package:hotelonwer/resources/components/coustmfields/bottm_sheet.dart';
import 'package:hotelonwer/resources/components/coustmfields/dropdown_button.dart';
import 'package:hotelonwer/resources/components/coustmfields/text_formfield2.dart';

import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class Adddatapage extends StatefulWidget {
  const Adddatapage({Key? key}) : super(key: key);

  @override
  State<Adddatapage> createState() => _AdddatapageState();
}

class _AdddatapageState extends State<Adddatapage> {
  String? selectedWifiAvailability;
  String? selectfoodavialbilty;
  String? refundoption;
  String? roomtype;
  String? Acoption;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController hotelNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController inceptionYearController = TextEditingController();
  final TextEditingController touristPlacesController = TextEditingController();
  final TextEditingController contactcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocBuilder<HotelBloc, HotelState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
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
                    maxLines: 3,
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
                            selectedWifiAvailability = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select wifi availability';
                            }
                            return null;
                          },
                          dropdownStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomDropdownButton<String>(
                          hintText: 'Room type',
                          value: roomtype,
                          items: const [
                            'Single room',
                            'Double room',
                            'Deluxe room',
                            'Studio room'
                          ],
                          onChanged: (value) {
                            roomtype = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please Select the room type';
                            }
                            return null;
                          },
                          dropdownStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextField2(
                    fillColor: mycolor4,
                    keyboardType: TextInputType.name,
                    controller: inceptionYearController,
                    hintText: 'Adress & landmark',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a correct Adress';
                      }
                      return null;
                    },
                    maxLines: 3,
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextField2(
                    fillColor: mycolor4,
                    keyboardType: TextInputType.multiline,
                    controller: touristPlacesController,
                    hintText: 'Enter nearest tourist places',
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter tourist places';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 1),
                          child: CustomDropdownButton<String>(
                            hintText: 'AC option',
                            value: Acoption,
                            items: const [
                              'Available',
                              'Non A/C',
                            ],
                            onChanged: (value) {
                              Acoption = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please Select AC type';
                              }
                              return null;
                            },
                            dropdownStyle: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: mycolor4,
                      labelText: 'Phone',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: mycolor3),
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    controller: contactcontroller,
                    initialCountryCode: 'IN', // Initial country code
                    validator: (value) {
                      if (value == null) {
                        return 'Phone is required';
                      }
                      // Additional validation can be added here if needed
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomDropdownButton<String>(
                          hintText: 'Food option',
                          value: selectfoodavialbilty,
                          items: const ['Free food', 'Paid'],
                          onChanged: (value) {
                            selectfoodavialbilty = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select food availability';
                            }
                            return null;
                          },
                          dropdownStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomDropdownButton<String>(
                          hintText: 'Refund option',
                          value: refundoption,
                          items: const ['Yes', 'No', '50%'],
                          onChanged: (value) {
                            refundoption = value;
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select refund option';
                            }
                            return null;
                          },
                          dropdownStyle: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            'name': hotelNameController.text.trim(),
                            'description': descriptionController.text.trim(),
                            'price': priceController.text.toString().trim(),
                            'locaton': locationController.text.trim(),
                            'sinceYear':
                                inceptionYearController.text.toString().trim(),
                            'touristlocaton':
                                touristPlacesController.text.trim(),
                            'foodoption': selectfoodavialbilty,
                            'Refundoption': refundoption,
                            'wifi': selectedWifiAvailability,
                            'contact': contactcontroller.text.toString().trim(),
                            'Room': roomtype,
                            'acoption': Acoption,
                            'images': '',
                            'coverimage': '',
                            'tourimage': '',
                            'pathimage': '',
                          };
                          // Form is valid, continue to next step
                          context.read<HotelBloc>().add(AddHotelData(data));
                          CustomBottomSheet().show(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 13, 52, 160),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        textStyle: const TextStyle(fontSize: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: mycolor4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
