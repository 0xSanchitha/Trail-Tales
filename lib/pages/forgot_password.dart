import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/pages/home.dart';
import 'package:trail_tales/pages/signup.dart';
import 'package:trail_tales/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

String email = "";
TextEditingController emailController = TextEditingController();

final _formkey = GlobalKey<FormState>();

bool isSending = false;

resetPassword()async{
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password Reset Email has been sent !",
    style: body,)));
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No user found for that Email.",
      style: body,)));
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            Container(
              alignment: Alignment.topCenter,
              child: Text("Password Recovery",
              style: h1.copyWith(color: Colors.black),),
            ),
            SizedBox(height: 10.0,),
            Text("Enter your mail",
            style: body.copyWith(color: Colors.black),),
            SizedBox(height: 50.0,),
            
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextFormField(
                  validator: (value) {
                  if(value==null||value.isEmpty){
                    return "Please enter Email";
                  }
                  return null;
                },
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: body2,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,
                      width: 2,)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black,
                      width: 2,)
                    )
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0,),
            SizedBox(height: 60, width: 270,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: btngray),
                onPressed: isSending ? null : () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text.trim();
                      isSending = true;
                    });

                    await resetPassword();

                    setState(() {
                      isSending = false;
                    });
                  }
                },
                child: Text("Send Email", 
                style: body.copyWith(
                  fontSize: 22,
                  letterSpacing: 10,)))),
                SizedBox(height: 50.0,),
                
                RichText(text: TextSpan(
                  text: "Don't have an account? ",
                  style: body2.copyWith(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                  children: [
                    TextSpan(
                      text: "Create",
                      style: body2.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                        decoration: TextDecoration.underline
                      ),
                      recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
                      }
                    )
                  ]
                ))
          ],
        ),
      ),
    );
  }
}