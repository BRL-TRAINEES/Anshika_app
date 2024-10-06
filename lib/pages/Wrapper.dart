import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/home.dart';
import 'package:form/pages/login.dart';

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
          builder: (context,snapshot){  // builder have all the snapshot of data so it helps to detect ki if data is here then go to Homepage else loginPage
           if(snapshot.hasData){
            return home();
           }else{
            return loginPage();
         }
          }),
    );
  }
}
