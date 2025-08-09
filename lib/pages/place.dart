// lib/pages/location.dart

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trail_tales/constants.dart';

class Location extends StatefulWidget {
  final List<String> images;
  final String title;
  final String details;
  final String location; // you can pass empty string if not used

  const Location({
    super.key,
    required this.images,
    required this.title,
    required this.details,
    required this.location,
  });

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
                      icon: getHeartIcon(),
                      onPressed: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
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
                  const SizedBox(height: 8),
                  if (widget.location.isNotEmpty)
                    Text(
                      widget.location,
                      style: text.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  const SizedBox(height: 30),

                  // Example info cards (customize or remove if not needed)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildInfoCard("Distance", "13KM"),
                        buildInfoCard("Temp", "20°C"),
                        buildInfoCard("Rate", "4.4"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "A b o u t   t h i s   p l a c e",
                    style: h1.copyWith(fontSize: 14, color: Colors.black),
                  ),

                  const SizedBox(height: 15),

                  Text(widget.details, style: text),

                  const SizedBox(height: 30),

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
                      "D i r e c t i o n",
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
