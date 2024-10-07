import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Forgot.dart';
import 'package:form/pages/Signup.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();  //that validates the saves the form
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

 bool isloading =false;

   logIn()async{
     setState(() {
       isloading=true;
     });
     try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text); //jaise hi yha login hua wrapper me stream changes observe krega toh snapshot aaygaa then abh snapshot pe data h toh hum homePage show krenge
     }on FirebaseAuthException catch(e){  //for firebase auth errors
Get.snackbar("error msg",e.code);
     }catch(e){  //for flutter errors
Get.snackbar(('error msg'), e.toString());
     }
setState(() {
  isloading=false;
});
  }

  @override
  Widget build(BuildContext context) {
    return isloading? Center(child: CircularProgressIndicator(),):Scaffold(  //means if loading is true then loading icon show hoga else scaffold
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 80, 90, 1),
        title: Text('Login' , style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),

          child: Form(
            key: _formKey,
            child: OverflowBar(
              overflowSpacing:40, //set space of 20 between all the widgets present in it
              children: [
                TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter valid Email';
                    }
                    return null;
                  },
                  controller: email,
                  cursorColor: Colors.green,
                  decoration:  InputDecoration(

                    labelText:'Email ID',
                    prefixIcon: Icon(Icons.email_sharp),
                    prefixIconColor: Color.fromRGBO(0, 80, 90, 1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 80, 90, 1),width: 3),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),

                TextFormField(
                  controller: password,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  cursorColor: Colors.green,
                  decoration:  InputDecoration(

                    labelText:'Password',
                    prefixIcon: Icon(Icons.password_sharp),
                    prefixIconColor: Color.fromRGBO(0, 80, 90, 1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 80, 90, 1),width: 3),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 80, 90, 1),
                    ),
                    child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),),
                    onPressed:logIn,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height:
                  55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 80, 90, 1),
                    ),
                    child: const Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 20),),
                    onPressed: (){
                      Get.to(()=>Signup());
                    },
                  ),
                  ),

                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     TextButton(
                        child: const Text('Forget password?',style: TextStyle(color: Color.fromRGBO(0, 80, 90, 1),fontSize: 20),),
                        onPressed: (){
                          Get.to(()=>Forgot());
                        },
                      ),
                   ],
                 ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}