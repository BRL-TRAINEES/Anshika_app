import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/googleSignIn.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:form/pages/Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  Future<void> signout() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the list of sign-in providers
        List<UserInfo> providerData = user.providerData;

        // Check if Google Sign-In was used
        bool isGoogle = providerData.any((userInfo) => userInfo.providerId == 'google.com');

        if (isGoogle) {
          // Sign out from Google Sign-In
          await GoogleSignIn().signOut().then((value)=>{
          Get.offAll(()=>LoginPage()),
          });
          print('User signed out from Google.');
        }

        // Sign out from Firebase (this will also sign out users signed in with email)
        await FirebaseAuth.instance.signOut();
        print('User signed out from Firebase.');
      }
    }catch (e) {
      print("Error during sign-out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out: ${e.toString()}')),
      );
    }
  }

  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(50,25, 100, 1),
          title: Text('Home Page' , style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text('Welcome to the app', style: TextStyle(color: Color.fromRGBO(50,25, 100, 1),fontSize: 40,fontWeight: FontWeight.bold),),
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: signout,
          child: Icon(Icons.login_rounded,),
        ),
      );

  }
}

