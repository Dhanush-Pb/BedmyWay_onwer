import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotelonwer/Screens/imagescreens/coverimage_add.dart';
import 'package:hotelonwer/coustmfields/theame.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';

class Hotelimageanddata extends StatefulWidget {
  final List<XFile> selectedImages;

  const Hotelimageanddata({Key? key, required this.selectedImages})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HotelimageanddataState createState() => _HotelimageanddataState();
}

class _HotelimageanddataState extends State<Hotelimageanddata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: mycolor5,
      // Your Scaffold content
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          // Your other widgets
          Expanded(
            child: widget.selectedImages.isEmpty
                ? const Center(
                    child: Text(
                      'No images selected',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemCount: widget.selectedImages.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageZoomView(
                                  imageFile: File(
                                    widget.selectedImages[index].path,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Material(
                            elevation: 15,
                            color: Colors.transparent,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(widget.selectedImages[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),

          // Your other widgets
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Coverimageadd()));
        },
        backgroundColor: mycolor3,
        child: Icon(
          Icons.check,
          color: mycolor5,
        ),
      ),
    );
  }
}

class ImageZoomView extends StatelessWidget {
  final File imageFile;

  const ImageZoomView({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mycolor3,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: FileImage(imageFile),
          backgroundDecoration: BoxDecoration(color: mycolor3),
        ),
      ),
    );
  }
}
