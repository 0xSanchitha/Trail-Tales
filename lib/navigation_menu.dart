import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trail_tales/pages/home.dart';
import 'package:trail_tales/pages/hotel.dart';
import 'package:trail_tales/pages/vehicle.dart';
import 'package:trail_tales/pages/wishlist.dart';


class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Hotel(),
    const Vehicle(),
    const Wishlist()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show selected screen
      bottomNavigationBar: ClipRRect(
        borderRadius:  const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: const Color(0xFF1E1E1E),
            indicatorColor: Colors.white24,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
              if (states.contains(MaterialState.selected)) {
                return const IconThemeData(color: Colors.white);
              }
              return const IconThemeData(color: Colors.white70);
            }),
          ),
          child: NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(icon: Icon(Iconsax.shop), label: "Hotel"),
              NavigationDestination(icon: Icon(Iconsax.car), label: "Vehicle"),
              NavigationDestination(icon: Icon(Iconsax.heart), label: "Wishlist"),
            ],
          ),
        ),
      ),
    );
  }
}
