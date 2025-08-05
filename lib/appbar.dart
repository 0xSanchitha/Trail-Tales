// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trail_tales/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          style: h1.copyWith(fontSize: 16, 
          color: Colors.black),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle
            ),
            child: IconButton(onPressed: () {
              //do something
            }, icon: Icon(Iconsax.notification, color: Colors.white,)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFF1E1E1E),
              shape: BoxShape.circle
            ),
            child: IconButton(onPressed: () {
              //do something
            }, icon: Icon(Iconsax.user, color: Colors.white,)),
          ),
        ),
      ],
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
