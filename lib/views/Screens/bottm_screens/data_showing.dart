import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelonwer/controller/bloc/hotel_bloc/bloc/hotel_bloc.dart';
import 'package:hotelonwer/resources/components/coustmfields/bottm_sheet2.dart';
import 'package:hotelonwer/resources/components/coustmfields/theame.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class Datalisttpage extends StatefulWidget {
  const Datalisttpage({Key? key}) : super(key: key);

  @override
  State<Datalisttpage> createState() => _DatalisttpageState();
}

class _DatalisttpageState extends State<Datalisttpage> {
  Future<void> _refreshData() async {
    context.read<HotelBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    log('it is details page');
    return Scaffold(
      backgroundColor: mycolor5,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.business_rounded,
              color: mycolor5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Text('My Hotels',
                  style: TextStyle(
                      color: mycolor4,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        backgroundColor: Mycolor1,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocConsumer<HotelBloc, HotelState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is Hoteldataloading) {
              log('loading');
              return Center(child: CircularProgressIndicator());
            } else if (state is HotelDataFetched) {
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  itemCount: state.Hotels.length,
                  itemBuilder: (context, index) {
                    final hotel = state.Hotels[index];
                    List<String> pathImageUrls = [];

                    if (hotel['coverimage'] is List<dynamic>) {
                      pathImageUrls =
                          (hotel['coverimage'] as List<dynamic>).map((item) {
                        return item is String ? item : '';
                      }).toList();
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                for (final imageUrl in pathImageUrls)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0,
                                        right: 12,
                                        left: 12,
                                        bottom: 12),
                                    child: GestureDetector(
                                      onTap: () {
                                        showHotelDetailsBottomSheet(
                                          context,
                                          imagePath: imageUrl,
                                          hotelName: hotel['name'] ?? '',
                                          location: hotel['locaton'] ?? '',
                                          address: hotel['sinceYear'] ?? '',
                                          onDelete: () {
                                            log('Delete button pressed for hotel: ${hotel['id']}');
                                            context.read<HotelBloc>().add(
                                                DeleteHotelData(hotel['id']));
                                          },
                                          onEdit: () {},
                                          hotelData: hotel,
                                        );
                                      },
                                      child: Container(
                                        width: constraints.maxWidth > 800
                                            ? 800
                                            : constraints.maxWidth,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              topLeft: Radius.circular(2)),
                                          color: mycolor4,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 4,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8),
                                                    bottomRight:
                                                        Radius.circular(8),
                                                    topLeft: Radius.circular(2),
                                                  ),
                                                  child: SizedBox(
                                                    width: 120,
                                                    height: 110,
                                                    child: Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (
                                                        BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress,
                                                      ) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          // Image successfully loaded
                                                          return child;
                                                        } else {
                                                          // Display shimmer effect while loading
                                                          return Shimmer
                                                              .fromColors(
                                                            baseColor: Colors
                                                                .grey[300]!,
                                                            highlightColor:
                                                                Colors
                                                                    .grey[100]!,
                                                            child: Container(
                                                              color: mycolor4,
                                                              width: 120,
                                                              height: 110,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      errorBuilder: (
                                                        BuildContext context,
                                                        Object exception,
                                                        StackTrace? stackTrace,
                                                      ) {
                                                        // Display shimmer effect on error
                                                        return Shimmer
                                                            .fromColors(
                                                          baseColor:
                                                              Colors.grey[300]!,
                                                          highlightColor:
                                                              Colors.grey[100]!,
                                                          child: Container(
                                                            color: mycolor4,
                                                            width: 120,
                                                            height: 110,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 35),
                                                  Text(
                                                    hotel['name'] ?? '',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    maxLines:
                                                        1, // Limits the text to a single line
                                                    overflow: TextOverflow
                                                        .ellipsis, // Ellipsis (...) indicates overflow
                                                  ),
                                                  SizedBox(height: 10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: Mycolor1),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 15),
                                                        child: Container(
                                                          constraints:
                                                              BoxConstraints(
                                                                  minWidth: 0),
                                                          child: Text(
                                                            '${hotel['locaton']}',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: const Color
                                                                  .fromARGB(255,
                                                                  80, 80, 80),
                                                            ),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (state is HotelDataError) {
              log('data not retrieved');
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('lib/Asset/Animation - 1716272013010.json',
                      width: 200)
                ],
              ));
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'lib/Asset/clip-no-connection.png',
                    width: 150,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Something went wrong, please try again'),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _refreshData();
                    // Add your refresh logic here
                  },
                  icon: Icon(Icons.refresh),
                  label: Text('Refresh'),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
