import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Home.dart';
import 'package:form/pages/Login.dart';
import 'package:form/pages/Verify.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){  // builder have all the snapshot of data
           if(snapshot.hasData) { //first check if snapshot has data then check
             print(snapshot.data);
             if (snapshot.data!.emailVerified) { //then check is email verified at that mail
               return Home();  //if yes go to home
             } else {
               return Verify();
             }
           }else {
               return LoginPage();  //if snapshot have no data then go to login page
    }
          },),
    );
  }
}
