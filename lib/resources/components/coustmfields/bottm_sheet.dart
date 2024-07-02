// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hotelonwer/Utils/alert_box.dart';
import 'package:hotelonwer/resources/components/coustmfields/transitrion.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotelonwer/views/Screens/imagescreens/hotel_image.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'dart:io';

class CustomBottomSheet {
  void show(BuildContext context) {
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
              Center(
                child: Column(
                  children: [
                    Text(
                      'Add your hotel images',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: mycolor4),
                    ),
                    Text(
                      'Maximum 5-10 images required for your hotel room.Each image should be around 250 KB in size.',
                      style: TextStyle(color: Mycolor1),
                      textAlign: TextAlign.center,
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
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                      color: mycolor4,
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

    if (selectedImages != null) {
      if (selectedImages.length > 10) {
        CustomErrorDialog.show(
            context, 'You can select a maximum of 10 images..');

        return;
      }

      List<XFile> validImages = [];
      for (XFile image in selectedImages) {
        final File file = File(image.path);
        final int fileSize = await file.length();
        print('file sizeis ${fileSize}');
        if (fileSize < 250 * 2160) {
          validImages.add(image);
        } else {
          CustomErrorDialog.show(
              context, 'All selected images exceed the size limit of 250 KB.');

          return;
        }
      }

      // Show a loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: Column(
            children: [
              Center(
                child: Image.asset(
                  'lib/Asset/Animation - 1716120910321.gif',
                  height: 150,
                  width: 150,
                ),
              )
            ],
          ));
        },
      );

      // Simulate image loading process
      await Future.delayed(const Duration(seconds: 2));

      // Close the loading dialog
      Navigator.of(context).pop();

      // Navigate to the next screen with a custom transition
      if (validImages.isNotEmpty) {
        Navigator.of(context).push(transition2(
          child: Hotelimageanddata(selectedImages: validImages),
          curve: Curves.bounceIn,
          axisDirection: AxisDirection.up,
        ));
      }
    }
  }
}
