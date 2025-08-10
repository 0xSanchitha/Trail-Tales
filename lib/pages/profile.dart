import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trail_tales/appbar.dart';
import 'package:trail_tales/constants.dart';
import 'package:trail_tales/pages/login.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String displayName = "No Name";

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  Future<void> fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          final nameFromFirestore = data['name'] as String?;

          setState(() {
            displayName = (nameFromFirestore != null && nameFromFirestore.isNotEmpty)
                ? nameFromFirestore
                : "No Name";
          });
        } else {
          setState(() {
            displayName = "No Name";
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          displayName = "No Name";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 239, 239),
      appBar: const CustomAppBar(title: "P R O F I L E"),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40,),
              Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black,width: 1)
              ),
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 35,
                ),
              ),
              SizedBox(height: 15,),
              Text(displayName,
              style: body.copyWith(color: Colors.black),),
              SizedBox(height: 20,),
              ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      "E d i t  P r o f i l e",
                      style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Icon(Icons.settings, color: primary,),
                        ),
                        SizedBox(width: 20,),
                        Text("S e t t i n g s", 
                        style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),),
                      Spacer(),
                      Icon(Icons.chevron_right,
                      color: black,
                      size: 30,)
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Icon(Icons.attach_money, color: primary,),
                        ),
                        SizedBox(width: 20,),
                        Text("P a y m e n t   D e t a i l s", 
                        style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),),
                      Spacer(),
                      Icon(Icons.chevron_right,
                      color: black,
                      size: 30,)
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Icon(Icons.manage_accounts, color: primary,),
                        ),
                        SizedBox(width: 20,),
                        Text("U s e r   M a n a g e m e n t", 
                        style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),),
                      Spacer(),
                      Icon(Icons.chevron_right,
                      color: black,
                      size: 30,)
                      ],
                    ),
                  ),

                  Divider(
                    color: Colors.grey[500],
                    thickness: 1,
                  ),

                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Icon(Icons.info, color: primary,),
                        ),
                        SizedBox(width: 20,),
                        Text("I n f o r m a t i o n", 
                        style: h1.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),),
                      Spacer(),
                      Icon(Icons.chevron_right,
                      color: black,
                      size: 30,)
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut(); // 🔑 Sign out the user

                      if (!context.mounted) return;

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Icon(Icons.logout, color: primary,),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          "L o g   O u t",
                          style: h1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.chevron_right, color: black, size: 30,)
                      ],
                    ),
                  ),

                  SizedBox(height: 60),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Trail Tales v1.0.0",
                          style: h1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "© 2025 Trail Tales. All rights reserved.",
                          style: h1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w100,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

            ] 
            
          ),
        ),
      ),
    );
  }
}
