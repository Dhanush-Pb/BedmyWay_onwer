// ignore_for_file: unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, await_only_futures

import 'dart:developer';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Utils/alert_box.dart';
import 'package:hotelonwer/Utils/snackbar_page.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:image_picker/image_picker.dart';

class Hotelroomreplce extends StatefulWidget {
  final List<dynamic> roomImages;
  final String documntid;

  const Hotelroomreplce(
      {Key? key, required this.roomImages, required this.documntid})
      : super(key: key);

  @override
  State<Hotelroomreplce> createState() => _HotelroomreplceState();
}

class _HotelroomreplceState extends State<Hotelroomreplce> {
  final List<Uint8List> _roomreplace = [];
  List<String> replacedRoomImages = []; // Maintain a list for replaced images
  bool _showReplacedImages = false; // Flag to show replaced images

  Future<void> _selectreplceroomimages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      List<Uint8List> imageDataList =
          await Future.wait(images.map((image) => image.readAsBytes()));
      setState(() {
        _roomreplace
            .addAll(imageDataList); // Add new selection to existing list
        _showReplacedImages = true; // Set flag to show replaced images
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _roomreplace.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter out non-string elements and convert them to strings
    List<String> validRoomImages = widget.roomImages
        .where((image) => image != null && image is String)
        .map<String>((image) => image as String)
        .toList();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload Room Photos',
            style: TextStyle(
                color: mycolor5, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Mycolor1,
          leading: IconButton(
            onPressed: _selectreplceroomimages,
            icon: Icon(Icons.add_photo_alternate_outlined, color: mycolor4),
          ),
        ),
        body: BlocConsumer<HotelBloc, HotelState>(
          listener: (context, state) {
            if (state is HotelImageReplaced) {
              setState(() {
                replacedRoomImages =
                    state.downloadUrl; // Update replaced images list
                _showReplacedImages = true; // Set flag to show replaced images
              });
            } else if (state is HotelDataError) {
              log(state.error);
            }
          },
          builder: (context, state) {
            // Decide which set of images to display
            List<String> imagesToShow = _showReplacedImages
                ? replacedRoomImages // Show replaced images if available
                : validRoomImages;
            // Show original images otherwise
            if (imagesToShow.isEmpty && _roomreplace.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/Asset/9264828.jpg',
                    width: 250,
                  )
                ],
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Adjust as needed
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: _showReplacedImages
                    ? _roomreplace.length
                    : imagesToShow.length,
                itemBuilder: (context, index) {
                  if (_showReplacedImages) {
                    // Display user-selected images for replacement
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.memory(
                              _roomreplace[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 15,
                          child: GestureDetector(
                            onTap: () {
                              _removeImage(index);
                            },
                            child: Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 255, 0, 0),
                              ),
                              child: Icon(
                                Icons.close,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Display current images
                    return GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: FadeInImage.assetNetwork(
                            placeholder:
                                'lib/Asset/techny-data-dashboard-with-charts-and-graphs.gif',
                            image: imagesToShow[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            placeholderScale: 1.0,
                            fadeInDuration: Duration(milliseconds: 300),
                            fadeOutDuration: Duration(milliseconds: 100),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.withOpacity(0.5),
                                child: Icon(
                                  Icons.error,
                                  color: Mycolor1,
                                  size: 40.0,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: mycolor3,
            child: Icon(
              Icons.cached_rounded,
              color: mycolor4,
            ),
            onPressed: () async {
              if (_roomreplace.isEmpty) {
                CustomSnackBar.show(context, 'Select some New images,',
                    duration: Duration(seconds: 2),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    textcolor: Colors.black,
                    backgroundColor: mycolor4);
                return;
              }
              for (Uint8List element in _roomreplace) {
                final int fileSize = await element.length;
                if (fileSize > 250 * 1024 || _roomreplace.length > 10) {
                  // Convert KB to bytes

                  CustomErrorDialog.show(context,
                      'You can select 10 images & maximum size up to 250 KB.');
                  return;
                }
              }
              log(_roomreplace.length.toString());

              if (_roomreplace.isNotEmpty) {
                // Only dispatch replace event if new images are selected
                BlocProvider.of<HotelBloc>(context)
                    .add(Repalaceimages(_roomreplace, widget.documntid));

                CustomSnackBar.show(context, 'Room Images Successfully Updated',
                    duration: Duration(seconds: 4),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    textcolor: Colors.black,
                    backgroundColor: mycolor4);
                await Future.delayed(Duration(seconds: 3));
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => BottomNavPage()),
                    (route) => false);
              }
            }));
  }
}
