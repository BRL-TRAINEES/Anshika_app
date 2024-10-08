import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Home.dart';
import 'package:form/pages/Signup.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class google_signIn extends StatefulWidget {
  const google_signIn({super.key});

  @override
  State<google_signIn> createState() => _google_signInState();
}

class _google_signInState extends State<google_signIn> {

  //google signIn function
  Future<void> google() async {
    try {
      // Sign in with Google and get the user's selected Google account
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create  new credential using the access token and id token
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the credential
      await FirebaseAuth.instance.signInWithCredential(credential);


      Get.offAll(() => Home());
    } catch (e) {
      // Handle sign-in errors
      print("Error during Google sign-in: $e");
      Get.snackbar('Error', 'Google sign-in failed: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(100, 0,40, 1),
        title: Text('Sign In with Google' ,style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(100, 0,40, 1),
              ),
                onPressed: google,
                child: Text('Google signIn',style: TextStyle(color: Colors.white),)
            ),
            TextButton(
              child: const Text('SignUp',style: TextStyle(color: Color.fromRGBO(100, 0, 40, 1),fontSize: 20),),
              onPressed: (){
                Get.to(()=>Signup());
              },
            ),
          ],
        ),
      ),
    );
  }
}


