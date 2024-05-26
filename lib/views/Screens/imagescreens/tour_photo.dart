// ignore_for_file: use_build_context_synchronously

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

class TouristImageReplace extends StatefulWidget {
  final List<dynamic> touristImages;
  final String documentId;
  final List<dynamic> coverimage;
  final List<dynamic> pathimage;
  const TouristImageReplace(
      {Key? key,
      required this.touristImages,
      required this.documentId,
      required this.coverimage,
      required this.pathimage})
      : super(key: key);

  @override
  State<TouristImageReplace> createState() => _TouristImageReplaceState();
}

class _TouristImageReplaceState extends State<TouristImageReplace> {
  final List<Uint8List> _touristImagesReplace = [];
  Uint8List? _coverImageReplace;
  Uint8List? _pathImageReplace;

  List<String> replacedTouristImages = [];
  String? replacedCoverImage;
  String? replacedPathImage;

  bool _showReplacedImages = false;

  Future<void> _selectReplaceTouristImages() async {
    final ImagePicker _picker = ImagePicker();
    List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      List<Uint8List> imageDataList =
          await Future.wait(images.map((image) => image.readAsBytes()));
      setState(() {
        _touristImagesReplace.addAll(imageDataList);
        _showReplacedImages = true;
      });
    }
  }

  Future<void> _selectReplaceCoverImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List imageData = await image.readAsBytes();
      setState(() {
        _coverImageReplace = imageData;
      });
    }
  }

  Future<void> _selectReplacePathImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Uint8List imageData = await image.readAsBytes();
      setState(() {
        _pathImageReplace = imageData;
      });
    }
  }

  bool _istaped = true;
  bool _containershow = false;

  @override
  Widget build(BuildContext context) {
    List<String> validTouristImages = widget.touristImages
        .where((image) => image != null && image is String)
        .map<String>((image) => image as String)
        .toList();
    List<String> validCoverImages = widget.coverimage
        .where((image) => image != null && image is String)
        .map<String>((image) => image as String)
        .toList();
    List<String> validPathImages = widget.pathimage
        .where((image) => image != null && image is String)
        .map<String>((image) => image as String)
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
                onPressed: () {
                  _selectReplaceTouristImages();
                },
                icon: Icon(Icons.add_photo_alternate_rounded),
                label: Text('New imges')),
          )
        ],
        backgroundColor: mycolor3,
        leading: IconButton(
            onPressed: () {
              setState(() {
                _containershow = !_containershow;
                _istaped = !_istaped;
              });
            },
            icon: _istaped
                ? Icon(
                    Icons.menu,
                    color: mycolor4,
                  )
                : Icon(
                    Icons.grid_view_rounded,
                    color: mycolor5,
                  )),
      ),
      backgroundColor: mycolor4,
      body: Stack(
        children: [
          BlocConsumer<HotelBloc, HotelState>(
            listener: (context, state) {
              if (state is HotelImageReplaced) {
                setState(() {
                  replacedTouristImages = state.downloadUrl;
                  _showReplacedImages = true;
                });
              } else if (state is HotelDataError) {
                log(state.error);
              }
            },
            builder: (context, state) {
              List<String> imagesToShow = _showReplacedImages
                  ? replacedTouristImages
                  : validTouristImages;

              if (imagesToShow.isEmpty && _touristImagesReplace.isEmpty) {
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
                  ),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                        ),
                        itemCount: _showReplacedImages
                            ? _touristImagesReplace.length
                            : imagesToShow.length,
                        itemBuilder: (context, index) {
                          if (_showReplacedImages) {
                            return Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.memory(
                                      _touristImagesReplace[index],
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
                                      setState(() {
                                        _touristImagesReplace.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color.fromARGB(
                                            255, 255, 0, 0),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
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
                                    fadeOutDuration:
                                        Duration(milliseconds: 100),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey.withOpacity(0.5),
                                        child: Icon(
                                          Icons.error,
                                          color: Colors.red,
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
                    ),
                  ),
                ],
              );
            },
          ),
          //!conotainser show
          if (_containershow)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: Container(
                    width: 310,
                    height: 550,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color:
                          Color.fromARGB(124, 255, 255, 255).withOpacity(0.3),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 10, left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _coverImageReplace != null
                                  ? Image.memory(_coverImageReplace!)
                                  : Image.network(validCoverImages[0]),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: _selectReplaceCoverImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mycolor5,
                                  ),
                                  height: 40,
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.business_rounded),
                                      Text(
                                        'Add image',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_coverImageReplace != null) {
                                    final int fileSize =
                                        _coverImageReplace!.length;
                                    if (fileSize > 250 * 1024) {
                                      CustomErrorDialog.show(context,
                                          'You can select image with maximum size up to 250 KB.');
                                      return;
                                    }

                                    BlocProvider.of<HotelBloc>(context).add(
                                        ReplaceCoverimages(
                                            [_coverImageReplace!],
                                            widget.documentId));
                                    setState(() {
                                      _containershow = false;
                                      _istaped = true;
                                    });
                                  } else {
                                    CustomSnackBar.show(context,
                                        'Please select Your Hotel image to replace.',
                                        duration: Duration(seconds: 2),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        textcolor: Colors.black,
                                        backgroundColor: mycolor4);
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mycolor5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.update),
                                      Text(
                                        'Replace..',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          //!pathimage
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: _pathImageReplace != null
                                  ? Image.memory(_pathImageReplace!)
                                  : Image.network(validPathImages[0]),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: _selectReplacePathImage,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mycolor5,
                                  ),
                                  height: 40,
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.photo_library_outlined),
                                      Text(
                                        'Add image',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_pathImageReplace != null) {
                                    final int fileSize =
                                        _pathImageReplace!.length;
                                    if (fileSize > 250 * 1024) {
                                      CustomErrorDialog.show(context,
                                          'You can select image with maximum size up to 250 KB.');
                                      return;
                                    }

                                    BlocProvider.of<HotelBloc>(context).add(
                                        ReplacePathimage([_pathImageReplace!],
                                            widget.documentId));
                                    setState(() {
                                      _containershow = false;
                                      _istaped = true;
                                    });
                                  } else {
                                    CustomSnackBar.show(
                                      context,
                                      'Please select offer/Promo image to replace.',
                                      duration: Duration(seconds: 2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      textcolor: Colors.black,
                                      backgroundColor: mycolor4,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: mycolor5,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: const [
                                      Icon(Icons.update),
                                      Text(
                                        'Replace..',
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.w600),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mycolor3,
        child: Icon(
          Icons.cached_rounded,
          color: mycolor4,
        ),
        onPressed: () async {
          if (_touristImagesReplace.isEmpty &&
              _coverImageReplace == null &&
              _pathImageReplace == null) {
            CustomSnackBar.show(context, 'Select some New images,',
                duration: Duration(seconds: 2),
                fontSize: 15,
                fontWeight: FontWeight.w700,
                textcolor: Colors.black,
                backgroundColor: mycolor4);
            return;
          }
          for (Uint8List element in _touristImagesReplace) {
            final int fileSize = element.length;
            if (fileSize > 250 * 1024 || _touristImagesReplace.length > 6) {
              CustomErrorDialog.show(context,
                  'You can select 5-6 images & maximum size up to 250 KB.');
              return;
            }
          }

          BlocProvider.of<HotelBloc>(context)
              .add(ReplaceTourimage(_touristImagesReplace, widget.documentId));

          CustomSnackBar.show(context, 'Images Successfully Updated',
              duration: Duration(seconds: 4),
              fontSize: 15,
              fontWeight: FontWeight.w700,
              textcolor: Colors.black,
              backgroundColor: mycolor4);
          await Future.delayed(Duration(seconds: 3));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavPage()),
              (route) => false);
        },
      ),
    );
  }
}
