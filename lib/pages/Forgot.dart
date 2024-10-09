import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController email = TextEditingController();

  reset() async {
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text).then((value)=>{
          Get.snackbar('Please check!','Password reset link has been sent to your email',backgroundColor: Colors.white)
        });
      }on FirebaseAuthException catch(e){  //for firebase auth errors
        Get.snackbar("error msg",e.code,backgroundColor: Colors.white);
      }catch(e) { //for flutter errors
        Get.snackbar(('error msg'), e.toString(),backgroundColor: Colors.white);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Reset Password', style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: OverflowBar(overflowSpacing: 40,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: 'Enter Email'),
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Text('Send Link',
                    style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: reset,
                ),
    ],
             ),

          ],
        ),
      ),
    );
  }
}
