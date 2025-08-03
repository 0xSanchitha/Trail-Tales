import 'package:flutter/material.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/pages/get_started_page.dart';
import 'package:trail_tales/pages/login.dart';

class signUpScreen extends StatelessWidget {
  const signUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        fit: StackFit.expand, // 🔑 Ensure Stack expands to full screen
        children: [
          Align(
            alignment: const Alignment(0, 0.3), // X: 0, Y: 0.3 => 30% below center
            child: Image.asset(
              'assets/signin_signup.png',
              width: 300,
              fit: BoxFit.contain,
            ),
          ),

          // Foreground content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SizedBox(height: 70),
                Transform.rotate(
                    angle: -0.5, // in **radians** (negative = rotate left, positive = right)
                    child: Image.asset(
                      'assets/logo.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 20),
                Text(
                  "Trail Tales",
                  style: h1.copyWith(
                    shadows: [
                      Shadow(
                        color: Colors.black.withAlpha((0.5 * 255).round()), // shadow color
                        offset: Offset(2, 2),                 // x and y offset
                        blurRadius: 4,                        // blur radius
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, right: 30),
                    child: Text(
                      "Create new Account",
                      style: body,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                customTextField(hint: "Username",),
                SizedBox(height: 20,),
                customTextField(hint: "Email",),
                SizedBox(height: 20,),
                customTextField(hint: "Password",),
                SizedBox(height: 25,),


                // SizedBox(height: 25,),

                SizedBox(height:  60, width: 270, child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: btngray),
                    onPressed: () {
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const GetStartedPage()),);
                    }, child: Text("Signup", style: body.copyWith(fontSize: 22, letterSpacing: 10),))),
                    SizedBox(height: 15,),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const loginScreen()),
                        );
                      },
                      child: Text(
                        "Already have an account",
                        style: body2.copyWith(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: 40,),
                    Text("Or continue with", 
                    style: body2.copyWith(fontSize: 18, color: const Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold,)),
                    SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.center ,children: [
                      socialButton(iconPath: "assets/google.png",),
                      SizedBox(width: 10,),
                      socialButton(iconPath: "assets/apple.png",)
                    ],)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class socialButton extends StatelessWidget {
  const socialButton({
    super.key, required this.iconPath
  });
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(height: 60, 
    width: 60,
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), borderRadius: BorderRadius.circular(30)
    ),
    child: Image.asset(iconPath,),
    );
  }
}

class customTextField extends StatelessWidget {
  const customTextField({
    super.key, required this.hint
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: white, 
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(30, 18, 5, 4),
        hintText: hint,
        hintStyle: body2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)
      ),
    );
  }
}
