import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(0, 255, 255, 255),
          ),
          onPressed: () {},
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
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (widget.selectedImages.isNotEmpty) {
            List<Uint8List> imagesDatas = [];
            for (var image in widget.selectedImages) {
              Uint8List imageDatas = await image.readAsBytes();
              imagesDatas.add(imageDatas);
            }
            // Dispatch an event to upload multiple images
            context.read<HotelBloc>().add(UploadHotelImage(imagesDatas));
          }

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
