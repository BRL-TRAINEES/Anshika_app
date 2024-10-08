
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Wrapper.dart';
import 'package:get/get.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized(); // is a method that ensures that the WidgetsBinding instance is properly initialized before Flutter framework is used.
  await Firebase.initializeApp();  // services that firebase is provide should be intialized before intialization of our app
  runApp(const MyApp());   // now app will run
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {  // this builds the UI of the widgets
    return GetMaterialApp(   // uses GetMaterial not Material wheneven we want to access methods of GEtX - getx-simple liberary that provides direct methods to go to any other screen and some popup methods to display any notification
      title: 'Form App',
      home:Wrapper(),    //The Wrapper widget serves as the starting point of the app, which checks the user's authentication state and decides which screen to display.

    );
  }
}
