import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotelonwer/Screens/bottm_screens/home_page.dart';
import 'package:hotelonwer/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/coustmfields/theame.dart';
import 'package:image_picker/image_picker.dart';

class Coverimageadd extends StatefulWidget {
  const Coverimageadd({Key? key}) : super(key: key);

  @override
  _CoverimageaddState createState() => _CoverimageaddState();
}

class _CoverimageaddState extends State<Coverimageadd> {
  File? _coverImage;
  File? _posterImage;
  List<File> _touristImages = [];

  Future<void> _selectImage(bool isCover) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (image != null) {
        if (isCover) {
          _coverImage = File(image.path);
        } else {
          _posterImage = File(image.path);
        }
      }
    });
  }

  Future<void> _selectMultipleTouristImages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage();

    setState(() {
      if (images != null) {
        _touristImages.addAll(images.map((image) => File(image.path)));
      }
    });
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
                                child: Image.file(
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
                                backgroundImage: FileImage(_posterImage!),
                              )
                            : const Column(
                                children: [
                                  Text(
                                    'select poster path image',
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
                                    child: Image.file(
                                      _touristImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                            : const Column(
                                children: [
                                  Text(
                                    'select the nearest tourist place images',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: GestureDetector(
          onTap: () {
            _saveHotelDetails();
          },
          child: Material(
            color: mycolor3,
            borderRadius: BorderRadius.circular(15),
            elevation: 20,
            child: Container(
              height: 50,
              width: 90,
              child: const Center(
                child: Text(
                  'Save your hotel details',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _saveHotelDetails() {
    if (_coverImage == null || _posterImage == null || _touristImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 1),
          content: const Text(
            'Please select all required images.',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: mycolor3,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => BottomNavPage()),
      );
    }
  }
}
