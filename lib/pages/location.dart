import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trail_tales/constants.dart';

class Location extends StatefulWidget {
  final List<String> images;

  const Location({super.key, required this.images});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  int _currentImage = 0;
  bool _isLiked = false;

  Icon getHeartIcon() {
    if (_isLiked) {
      return const Icon(Icons.favorite, color: Colors.red,);
    } else {
      return const Icon(Icons.favorite_border, color: Colors.white);
    }
  }

  List<Widget> buildIndicators() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.images.length; i++) {
      bool isActive = i == _currentImage;
      indicators.add(
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 20 : 8,
          decoration: BoxDecoration(
            color: isActive ? primary : Colors.grey[400],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    }
    return indicators;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Stack for slider + buttons
          Stack(
            children: [
              // Slider with rounded bottom corners
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 340,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: false,
                    autoPlay: false,
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

          // Indicator dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildIndicators()
          ),

          const SizedBox(height: 20),
        ],
      ),

    );
  }
}
