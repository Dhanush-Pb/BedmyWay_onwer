// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:image_picker/image_picker.dart';

class Coverimageadd extends StatefulWidget {
  const Coverimageadd({Key? key}) : super(key: key);

  @override
  _CoverimageaddState createState() => _CoverimageaddState();
}

class _CoverimageaddState extends State<Coverimageadd> {
  Uint8List? _coverImage;
  Uint8List? _posterImage;
  List<Uint8List> _touristImages = [];

  Future<void> _selectImage(bool isCover) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List imageData = await image.readAsBytes();
      setState(() {
        if (isCover) {
          _coverImage = imageData;
        } else {
          _posterImage = imageData;
        }
      });
    }
  }

  Future<void> _selectMultipleTouristImages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      List<Uint8List> imageDataList =
          await Future.wait(images.map((image) => image.readAsBytes()));
      setState(() {
        _touristImages.addAll(imageDataList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: mycolor3,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () => _selectImage(true),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mycolor3,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: _coverImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  _coverImage!,
                                  fit: BoxFit.cover,
                                  height: 200, // Adjusted size
                                ),
                              )
                            : Container(
                                color: mycolor3,
                                child: const Column(
                                  children: [
                                    Text(
                                      'Select cover image',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.image_outlined,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _selectImage(false),
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mycolor3,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: _posterImage != null
                            ? CircleAvatar(
                                radius: 90,
                                backgroundImage: MemoryImage(_posterImage!),
                              )
                            : const Column(
                                children: [
                                  Text(
                                    'Select poster image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _selectMultipleTouristImages,
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: mycolor3,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: _touristImages.isNotEmpty
                            ? GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: _touristImages.length,
                                itemBuilder: (context, index) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.memory(
                                      _touristImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                            : const Column(
                                children: [
                                  Text(
                                    'Select nearest tourist place images',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.beach_access_outlined,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<HotelBloc, HotelState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: GestureDetector(
              onTap: () {
                if (_coverImage == null ||
                    _posterImage == null ||
                    _touristImages.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(seconds: 1),
                      content: const Text(
                        'Please select all required images.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      backgroundColor: mycolor3,
                      behavior: SnackBarBehavior.floating,
                      margin: const EdgeInsets.only(
                          bottom: 15, left: 25, right: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  );
                } else {
                  final hotelBloc = BlocProvider.of<HotelBloc>(context);

                  List<Uint8List> Coverimagelist = [
                    _coverImage!,
                  ];
                  List<Uint8List> Posterimagelist = [
                    _posterImage!,
                  ];

                  List<Uint8List> Tourstimagelist = _touristImages;

                  hotelBloc.add(Uploadcoverimages(coverimaged: Coverimagelist));
                  hotelBloc.add(Uploadpathimages(pathimages: Posterimagelist));

                  hotelBloc.add(Uploadtouriamges(tourimages: Tourstimagelist));
                  // final tourstimage = {
                  //   'tourimage': _touristImages,
                  //   'coverimage': _coverImage,
                  //   'pathimage': _posterImage,
                  // };

                  // hotelBloc
                  //     .add(UpdateHotelData(tourstimage, id: hotelBloc.a!.id));

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BottomNavPage()),
                    (route) => false, // This will remove all the routes
                  );
                }
              },
              child: Material(
                color: mycolor3,
                borderRadius: BorderRadius.circular(15),
                elevation: 20,
                child: SizedBox(
                  height: 50,
                  width: 90,
                  child: const Center(
                    child: Text(
                      'Save your hotel details',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
