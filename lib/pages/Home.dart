import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
 void signout()async{
    await FirebaseAuth.instance.signOut();
  }
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      ),
    );;
  }
}

