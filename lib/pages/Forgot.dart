import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Forgot extends StatefulWidget {
  const Forgot({super.key});

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {

  TextEditingController email = TextEditingController();

  reset() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
              children: [ ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
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
