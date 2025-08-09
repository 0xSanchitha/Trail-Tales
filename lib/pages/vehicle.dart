import 'package:flutter/material.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/searchbar.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
          // Tab bar under the app bar
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    const SearchBarWidget(),
                    const SizedBox(height: 20),
                    // Tab views
                    SizedBox(
                      height: 500, // adjust as needed
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          BicycleTab(),
                          Center(child: Text("Tuk Tuk Rentals")),
                          Center(child: Text("Car Rentals")),
                          Center(child: Text("Jeep Rentals")),
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
        SizedBox(height: 5,),
        Text("P i c k   Y o u r   R i d e",
        style: h1.copyWith(fontSize: 14, color: Colors.black),)
      ],
    );
  }
}
