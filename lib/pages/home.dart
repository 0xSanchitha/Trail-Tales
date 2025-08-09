import 'package:flutter/material.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/models/place_models.dart';
import 'package:trail_tales/pages/location.dart';
import 'package:trail_tales/searchbar.dart';
import 'package:trail_tales/service/firestore_service.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentSlide = 0;
  late Future<List<Place>> _mostPopularFuture; // for carousel
  late Future<List<Place>> _placesGridFuture;  // for grid

  @override
  void initState() {
    super.initState();
    final firestoreService = FirestoreService();
    _mostPopularFuture = firestoreService.fetchMostPopularPlaces(); // carousel
    _placesGridFuture = firestoreService.fetchPlaces();             // grid
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const CustomAppBar(title: "D I S C O V E R"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              SearchBarWidget(),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Discover places to visit, find restaurants and villas, rent vehicles, and create your travel route — all in one app.",
                  style: text.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 10),
        
              FutureBuilder<List<Place>>(
                future: _mostPopularFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading places"));
                  }
        
                  final places = snapshot.data ?? [];
        
                  if (places.isEmpty) {
                    return const Center(child: Text("No places found."));
                  }
        
                  return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 230,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          scrollPhysics: const BouncingScrollPhysics(),
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentSlide = index;
                            });
                          },
                        ),
                        items: places.map((place) {
                          return SliderItems(
                            key: ValueKey(place.title), // 🔑 unique key
                            imageUrl: place.image,
                            title: place.title,
                            description: place.description,
                            onReadMore: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Location(images: place.images,
                              title: place.title,
                              details: place.details,
                              location: place.location,)));
                            },
                          );
                        }).toList(),
                      ),
        
                      const SizedBox(height: 10),
        
                      // 🔽 Rounded bar indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(places.length, (index) {
                          bool isActive = index == _currentSlide;
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
                        }),
                      ),
                      const SizedBox(height: 20,),
        
                      Text("D i s c o v e r   E v e r y w h e r e",style: h1.copyWith(fontSize: 14, 
                        color: Colors.black),),
        
                      const SizedBox(height: 20),
        
                      // const SizedBox(height: 20),

                      FutureBuilder<List<Place>>(
                        future: _placesGridFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return const Center(child: Text("Error loading places"));
                          }

                          final placesGrid = snapshot.data ?? [];

                          if (placesGrid.isEmpty) {
                            return const Center(child: Text("No places found."));
                          }

                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: placesGrid.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 3 / 4,
                            ),
                            itemBuilder: (context, index) {
                              final place = placesGrid[index];

                              // Build your images list for the carousel
                              final imagesList = <String>[];
                              if (place.image.isNotEmpty) imagesList.add(place.image);
                              if (place.images.isNotEmpty) imagesList.addAll(place.images); 
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Location(
                                        images: imagesList,
                                        title: place.title,
                                        details: place.details,
                                        location: place.location,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl: place.image,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          placeholder: (context, url) =>
                                              const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          place.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: h1.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },

                          );
                        },
                      ),


        
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SliderItems extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final VoidCallback onReadMore;

  SliderItems({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onReadMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.6),
          ),

          // Text content
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  title,
                  style: h1.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: onReadMore,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "R e a d   M o r e...",
                    style: body.copyWith(color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}