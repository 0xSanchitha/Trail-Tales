// lib/pages/location.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trail_tales/constants.dart';

class Bookings extends StatefulWidget {
  final List<String> images;
  final String title;
  final String location;
  final String bedrooms;
  final String price;
  final String rating;
  final String reviews;
  final String details;
  final String info;
  final String name;

  const Bookings({
    super.key,
    required this.images,
    required this.title,
    required this.location,
    required this.bedrooms,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.details,
    required this.info,
    required this.name,
  });

  @override
  State<Bookings> createState() => _LocationState();
}

class _LocationState extends State<Bookings> {
  int _currentImage = 0;
  bool _isLiked = false;

  Icon getHeartIcon() {
    return _isLiked
        ? const Icon(Icons.favorite, color: Colors.red)
        : const Icon(Icons.favorite_border, color: Colors.white);
  }

  List<Widget> buildIndicators() {
    return List.generate(widget.images.length, (i) {
      final isActive = i == _currentImage;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 8,
        width: isActive ? 20 : 8,
        decoration: BoxDecoration(
          color: isActive ? primary : Colors.grey[400],
          borderRadius: BorderRadius.circular(20),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 340,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImage = index;
                        });
                      },
                    ),
                    items: widget.images.map((imgUrl) {
                      return CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                    ),


                  ),
                ),
                Positioned(
                  top: 30,
                  right: 60,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildIndicators(),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: h1.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (widget.location.isNotEmpty)
                    Text("Room in ${widget.location}",
                      style: text.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                  const SizedBox(height: 2),
                  if (widget.info.isNotEmpty)
                    Text(
                      widget.info,
                      style: text.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Container(
                  //   height: 100,
                  //   width: double.infinity,
                  //   clipBehavior: Clip.hardEdge,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: Border.all(color: Colors.black,width: 1)
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric( vertical: 15),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Column(
                  //           children: [
                  //             Text(
                  //               widget.rating,
                  //               style: text.copyWith(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 18,
                  //               ),
                  //             ),
                  //             const SizedBox(height: 5),
                  //             Row(
                  //               mainAxisSize: MainAxisSize.min,
                  //               children: List.generate(5, (index) {
                  //                 if (index < 4) {
                  //                   // filled star
                  //                   return const Icon(Icons.star, color: Colors.black, size: 20);
                  //                 } else {
                  //                   // outlined star
                  //                   return const Icon(Icons.star_border, color: Colors.black, size: 20);
                  //                 }
                  //               }),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           children: [
                  //             Text(
                  //               widget.reviews,
                  //               style: text.copyWith(
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 18,
                  //               ),
                  //             ),
                  //             const SizedBox(height: 5),
                  //             Text("Reviews",
                  //             style: text.copyWith(
                  //               fontWeight: FontWeight.normal,
                  //               fontSize: 16,
                  //               decoration: TextDecoration.underline
                  //             ),
                  //           ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),

                  // ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Distance
                        buildInfoCard("Distance", "13km"),
                        // Temp
                        buildInfoCard(
                          "Rate", widget.rating,
                        ),
                        // Rate
                        buildInfoCard("Reviews", widget.reviews),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Divider(
                    color: Colors.black,
                    thickness: 1,

                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 24,
                        ),
                      ),

                      SizedBox(width: 20,),
                      Text("Stay with ${widget.name}",
                      style: body.copyWith(color: Colors.black),)
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    color: Colors.black,
                    thickness: 1,

                  ),

                  const SizedBox(height: 30),

                  Text(
                    "A b o u t   t h i s   p l a c e",
                    style: h1.copyWith(fontSize: 18, color: Colors.black),
                  ),

                  const SizedBox(height: 15),

                  Text(widget.details, style: text),

                  const SizedBox(height:20),

                  Text("Where you'll be",
                  style: h1.copyWith(fontSize: 18, color: Colors.black)),

                  SizedBox(height: 5,),

                  Text(widget.location, 
                  style: text.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),),

                  SizedBox(height: 20,),

                  Center(
                    child: Container(
                      width: 350,
                      height: 350,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black,width: 1)
                      ),
                      child: Center(
                        child: Text("Map Placeholder",
                        style: h1.copyWith(fontSize: 18, color: Colors.black,
                        fontWeight: FontWeight.w200)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.price,
              style: h1.copyWith(fontSize: 18, color: Colors.black,
              fontWeight: FontWeight.w200),
            ),
            ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      "R e s e r v e",
                      style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String label, String value) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 241, 241, 241),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: text.copyWith(fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: h1.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
