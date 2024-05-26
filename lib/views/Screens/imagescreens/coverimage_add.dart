// import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/Bottm_page.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:hotelonwer/views/Screens/bottm_screens/data_showing.dart';
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

    List<Uint8List> imageDataList =
        await Future.wait(images.map((image) => image.readAsBytes()));
    setState(() {
      _touristImages.addAll(imageDataList);
    });
  }

  void _onSave() async {
    if (_coverImage == null || _posterImage == null || _touristImages.isEmpty) {
      _showErrorDialog('Please select all required images.');
    } else if (_touristImages.length < 5 || _touristImages.length > 6) {
      _showErrorDialog(
          'Please select between 5 and 6 tourist images & maximum size up to 250 KB.');
    } else {
      _showLoadingSnackBar('Please wait, hotel details saving...');

      final hotelBloc = BlocProvider.of<HotelBloc>(context);

      List<Uint8List> coverImageList = [_coverImage!];
      List<Uint8List> posterImageList = [_posterImage!];
      List<Uint8List> touristImageList = _touristImages;

      await Future.delayed(Duration(seconds: 6));

      hotelBloc.add(Uploadcoverimages(coverimaged: coverImageList));
      hotelBloc.add(Uploadpathimages(pathimages: posterImageList));
      hotelBloc.add(Uploadtouriamges(tourimages: touristImageList));

      // Navigate back after saving images
      Navigator.of(context)
          .pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => BottomNavPage()),
        (route) => false,
      )
          .then((_) {
        Datalisttpage();
        print('Navigation to BottomNavPage complete!');
      });
    }
  }

  void _showLoadingSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 15), // Adjust duration as needed
        content: Row(
          children: [
            CircularProgressIndicator(
              color: mycolor3,
            ),
            SizedBox(width: 25),
            Text(
              message,
              style: TextStyle(color: mycolor3),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset(
                'lib/Asset/techny-data-dashboard-with-charts-and-graphs.gif',
                width: 200,
              ),
            ],
          ),
          content: Text(message,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600, color: Mycolor1)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTouristImagePreview(Uint8List imageData, int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            imageData,
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _touristImages.removeAt(index);
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                    padding: const EdgeInsets.all(8.0),
                    child: _coverImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _coverImage!,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          )
                        : Container(
                            height: 80,
                            width: double.infinity,
                            color: mycolor3,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select cover image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
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
                    padding: const EdgeInsets.all(8.0),
                    child: _posterImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              _posterImage!,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                            ),
                          )
                        : Container(
                            height: 80,
                            width: double.infinity,
                            color: mycolor3,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select your hotel image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
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
                    padding: const EdgeInsets.all(10.0),
                    child: _touristImages.isNotEmpty
                        ? GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: _touristImages.length,
                            itemBuilder: (context, index) {
                              return _buildTouristImagePreview(
                                  _touristImages[index], index);
                            },
                          )
                        : Container(
                            height: 80,
                            width: double.infinity,
                            color: mycolor3,
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Select nearest tourist place images',
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 10),
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
              onTap: _onSave,
              child: Material(
                color: mycolor3,
                borderRadius: BorderRadius.circular(15),
                elevation: 20,
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
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
