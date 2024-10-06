import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
 void signout()async{
    await FirebaseAuth.instance.signOut();
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
          child: Text('Congrulations ! You have successfull loged in', style: TextStyle(color: Color.fromRGBO(50,25, 100, 1),fontSize: 40,fontWeight: FontWeight.bold),),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: signout,
        child: Icon(Icons.login_rounded,),
      ),
    );;
  }
}

