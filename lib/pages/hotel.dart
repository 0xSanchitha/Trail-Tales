import 'package:flutter/material.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/searchbar.dart';
import 'package:trail_tales/service/firestore_service.dart';
import 'package:trail_tales/models/hotel_model.dart';
import 'package:cached_network_image/cached_network_image.dart';


class Hotel extends StatefulWidget {
  const Hotel({super.key});
    

  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<HotelModel>> _hotelsFuture;

  @override
  void initState() {
    super.initState();
    _hotelsFuture = _firestoreService.fetchHotels();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(239, 239, 239, 1),
      appBar: const CustomAppBar(title: "B O O K I N G S"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              SearchBarWidget(),
              SizedBox(height: 20),
              Container(
                height: 150,
                width: double.infinity,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/discount.png"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("50%", style: h1.copyWith(fontSize: 60)),
                    Text("Off of\nfirst\nBooking", style: body.copyWith(fontSize: 22)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "F i n d   Y o u r   S t a y",
                style: h1.copyWith(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 20),

              // Here we load the hotels dynamically
              FutureBuilder<List<HotelModel>>(
                future: _hotelsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hotels found'));
                  }

                  final hotels = snapshot.data!;

                  return Column(
                    children: hotels.map((hotel) => HotelCard(hotel: hotel)).toList(),
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

class HotelCard extends StatefulWidget {
  final HotelModel hotel;
  const HotelCard({super.key, required this.hotel});

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool isLiked = false; // track heart state for this card

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: widget.hotel.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.hotel.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 180,
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/placeholder.png',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(
                    'assets/placeholder.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.hotel.title, style: body.copyWith(color: Colors.black)),
                const SizedBox(height: 8),
                Text(widget.hotel.location, style: text.copyWith(color: Colors.grey[700])),
                const SizedBox(height: 4),
                Text(widget.hotel.bedrooms, style: text.copyWith(color: Colors.grey[700])),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.hotel.price, style: body.copyWith(color: Colors.teal)),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLiked = !isLiked; // toggle state
                            });
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.hotel.rating,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
