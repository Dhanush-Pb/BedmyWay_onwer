import 'package:flutter/material.dart';

import 'package:hotelonwer/coustmfields/bottm_sheet.dart';
import 'package:hotelonwer/coustmfields/dropdown_button.dart';
import 'package:hotelonwer/coustmfields/text_formfield2.dart';

import 'package:hotelonwer/coustmfields/theame.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: mycolor5,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                CustomTextField2(
                  fillColor: mycolor4,
                  keyboardType: TextInputType.name,
                  controller: TextEditingController(),
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
                  controller: TextEditingController(),
                  maxLines: 6,
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
                        items: const ['Available', 'Not Available', 'Limited'],
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
                          'double room',
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
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(),
                  hintText: 'Enter price',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
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
                        fillColor: mycolor4,
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(),
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
                        controller: TextEditingController(),
                        hintText: 'Year of Inception',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter establishment year';
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
                  controller: TextEditingController(),
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
                        // Form is valid, continue to next step
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
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
