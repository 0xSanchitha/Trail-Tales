import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/models/vehicle_model.dart';
import 'package:trail_tales/searchbar.dart';
import 'package:trail_tales/service/firestore_service.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> with SingleTickerProviderStateMixin {
  final FirestoreService _firestoreService = FirestoreService();
  late Future<List<VehicleModel>> _vehicleFuture;
  late TabController _tabController;
  final List<String> vehicleCollections = ['Bicycle', 'Tuk Tuk', 'Car', 'jeep'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _vehicleFuture = _firestoreService.fetchVehicles(vehicleCollections[0]); // initial tab Bicycle

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _vehicleFuture = _firestoreService.fetchVehicles(vehicleCollections[_tabController.index]);
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const CustomAppBar(title: "R E N T A L"),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: "Bicycle"),
                Tab(text: "Tuk Tuk"),
                Tab(text: "Car"),
                Tab(text: "Jeep"),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<VehicleModel>>(
              future: _vehicleFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Vehicle Found'));
                }

                final vehicles = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: [
                        const SearchBarWidget(),
                        const SizedBox(height: 15),
                        Center(
                          child: Text(
                            "P i c k   Y o u r   R i d e",
                            style: h1.copyWith(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: vehicles.length,
                          itemBuilder: (context, index) {
                            return VehicleCard(vehicle: vehicles[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class BicycleTab extends StatelessWidget {
  const BicycleTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
      ],
    );
  }
}

class VehicleCard extends StatefulWidget {
  final VehicleModel vehicle;
  const VehicleCard({super.key, required this.vehicle});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  bool isLiked = false;

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
            child: widget.vehicle.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: widget.vehicle.imageUrl,
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
                Text(widget.vehicle.title, style: body.copyWith(color: Colors.black)),
                const SizedBox(height: 8),
                Text(widget.vehicle.location, style: text.copyWith(color: Colors.grey[700])),
                const SizedBox(height: 4),
                Text(widget.vehicle.renter, style: text.copyWith(color: Colors.grey[700])),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.vehicle.price, style: body.copyWith(color: Colors.teal)),
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
                            widget.vehicle.rating,
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