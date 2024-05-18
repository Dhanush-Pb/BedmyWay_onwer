import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotelonwer/views/Screens/imagescreens/hotel_image.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';

class CustomBottomSheet {
  show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: mycolor3,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Add your hotel images',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      'Minimum 5-6 images required for your hotel room',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    selectImages(context);
                  },
                  child: const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.photo_library,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  static Future<void> selectImages(BuildContext context) async {
    final ImagePicker imagePicker = ImagePicker();
    List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(transition2(
          child: Hotelimageanddata(selectedImages: selectedImages),
          curve: Curves.easeIn,
          axisDirection: AxisDirection.left));
    }
  }
}
