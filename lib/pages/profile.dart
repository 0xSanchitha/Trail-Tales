import 'package:flutter/material.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const CustomAppBar(title: "P R O F I L E"),
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
