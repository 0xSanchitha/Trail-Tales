import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/navigation_menu.dart';
import 'package:trail_tales/pages/home.dart';
import 'package:trail_tales/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trail_tales/service/auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState  extends State<SignUpScreen> {

String email = "", password = "", name = "";
TextEditingController nameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController= new TextEditingController();

final _formkey = GlobalKey<FormState>();

registration() async {
  email = emailController.text.trim();
  password = passwordController.text.trim();
  name = nameController.text.trim();

  if (password.isNotEmpty && name.isNotEmpty && email.isNotEmpty) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Update the Firebase user profile displayName
      await userCredential.user?.updateDisplayName(name);
      await userCredential.user?.reload();
      
      final user = FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("User")
          .doc(user?.uid)
          .set({
        "uid": user?.uid,
        "name": name,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registered Successfully!", style: body),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavigationMenu()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password provided is too weak!", style: body.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Account already exists!", style: body.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration failed: ${e.message}", style: body.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong!", style: body.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold)),
        ),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Stack(
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

            // Foreground content with scrolling to prevent overflow
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                              offset: Offset(2, 2), // x and y offset
                              blurRadius: 4, // blur radius
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
                      SizedBox(height: 20),
                      CustomTextField(hint: "Username", controller: nameController),
                      SizedBox(height: 20),
                      CustomTextField(hint: "Email", controller: emailController),
                      SizedBox(height: 20),
                      CustomTextField(hint: "Password", controller: passwordController, isPassword: true),
                      SizedBox(height: 25),

                      SizedBox(
                        height: 60,
                        width: 270,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: btngray),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                                name = nameController.text;
                                password = passwordController.text;
                              });
                              registration();
                            }
                          },
                          child: Text(
                            "Signup",
                            style: body.copyWith(fontSize: 22, letterSpacing: 10),
                          ),
                        ),
                      ),
                      SizedBox(height: 15,),


                      // SizedBox(
                      //   height: 60,
                      //   width: 270,
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       if (_formkey.currentState!.validate()) {
                      //         setState(() {
                      //           email = emailController.text;
                      //           name = nameController.text;
                      //           password = passwordController.text;
                      //         });
                      //         registration();
                      //       }
                      //     },
                      //     child: ElevatedButton(
                      //       style: ElevatedButton.styleFrom(backgroundColor: btngray),
                      //       onPressed: null, // Disable internal onPressed, GestureDetector handles tap
                      //       child: Text(
                      //         "Signup",
                      //         style: body.copyWith(fontSize: 22, letterSpacing: 10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 15),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                      SizedBox(height: 40),
                      Text(
                        "Or continue with",
                        style: body2.copyWith(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                          onTap: () {
                            AuthMethods().signInWithGoogle(context);
                          },
                          child: SocialButton(iconPath: "assets/google.png")),
                          SizedBox(width: 10),
                          SocialButton(iconPath: "assets/apple.png"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class SocialButton extends StatelessWidget {
  const SocialButton({
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

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    required this.hint,
    required this.controller,
    this.isPassword = false,
  });

  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: (value) {
        if(value==null||value.isEmpty){
          return "Please enter ${hint.toLowerCase()}";
        }
        return null;
      },
      controller: controller,
      decoration: InputDecoration(
        fillColor: white, 
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(30, 18, 5, 4),
        hintText: hint,
        hintStyle: body2,
        errorStyle: TextStyle(
          color: const Color.fromARGB(255, 255, 91, 91),
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)
      ),
    );
  }
}
