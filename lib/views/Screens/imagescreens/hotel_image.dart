import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/Utils/alert_box.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hotelonwer/views/Screens/imagescreens/coverimage_add.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:photo_view/photo_view.dart';

import '../../../controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';

class Hotelimageanddata extends StatefulWidget {
  final List<XFile> selectedImages;

  const Hotelimageanddata({Key? key, required this.selectedImages})
      : super(key: key);

  @override
  _HotelimageanddataState createState() => _HotelimageanddataState();
}

class _HotelimageanddataState extends State<Hotelimageanddata> {
  void _removeImage(int index) {
    setState(() {
      widget.selectedImages.removeAt(index);
    });
  }

  void _selectImagesAgain() async {
    final List<XFile>? newImages = await ImagePicker().pickMultiImage();
    if (newImages != null) {
      setState(() {
        widget.selectedImages.addAll(newImages);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.add_photo_alternate_rounded,
            size: 35,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          onPressed: () {
            _selectImagesAgain();
          },
        ),
        backgroundColor: mycolor3,
      ),
      backgroundColor: mycolor5,
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelDataError) {
            print(state.error); // Use state.error to print error details
          }
          return Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: widget.selectedImages.isEmpty
                    ? Center(
                        child: Text(
                          'No images selected',
                          style: TextStyle(color: mycolor4),
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
                            return Stack(
                              fit: StackFit.expand,
                              children: [
                                GestureDetector(
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
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      _removeImage(index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: mycolor4,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Mycolor1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (widget.selectedImages.length > 10) {
            CustomErrorDialog.show(context,
                'Please limit your selection to 10 images &maximum size up to 250 KB');
          } else if (widget.selectedImages.length <= 10) {
            List<Uint8List> imagesDatas = [];
            for (var image in widget.selectedImages) {
              Uint8List imageDatas = await image.readAsBytes();
              imagesDatas.add(imageDatas);
            }
            // Dispatch an event to upload multiple images
            context.read<HotelBloc>().add(UploadHotelImage(imagesDatas));

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const Coverimageadd()));
          }
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
