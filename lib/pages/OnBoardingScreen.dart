import 'package:flutter/material.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/pages/login.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // 🔑 Ensure Stack expands to full screen
        children: [
          // Background image
          Image.asset(
            'assets/bg.jpg',
            fit: BoxFit.cover,
          ),

          // Foreground content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                children: [
                  SizedBox(height: 150),
                  Transform.rotate(
                    angle: -0.5, // in **radians** (negative = rotate left, positive = right)
                    child: Image.asset(
                      'assets/logo.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 80),
                  Text("Trail Tales", 
                  style: h2,
                  textAlign: TextAlign.center,),
                  SizedBox(height: 15),
                  Text("Wander Freely. Travel Cozy.", style: body,
                  textAlign: TextAlign.center,),
                  SizedBox(height: 70),
                  SizedBox(height:  60, width: 170, child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: primary),
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const loginScreen()),);
                    }, child: Text("Get Started", style: body,)))
                ],
              ),
          )
        ],
      ),
    );
  }
}
