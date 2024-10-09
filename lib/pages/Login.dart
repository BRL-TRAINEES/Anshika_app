import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Forgot.dart';
import 'package:form/pages/Signup.dart';
import 'package:form/pages/googleSignIn.dart';
import 'package:form/pages/PhoneNumber.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();  //that validates and saves the form and uniquely identifies the forms

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obsecureText =true;


  void _toggglePasswordVisibility(){
    setState(() {
      _obsecureText  = !_obsecureText;
    });
  }


 bool isloading =false;
// log in func
   logIn()async{
     setState(() {
       isloading=true;
     });

     try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text).then((value)=>{
       Get.snackbar("Dear User!","Register Successful",backgroundColor: Colors.white),
       });    //jaise hi yha login hua wrapper me stream changes observe krega toh snapshot aaygaa then abh snapshot pe data h toh hum homePage show krenge
     }on FirebaseAuthException catch(e){  //for firebase auth errors
Get.snackbar("error msg",e.code,backgroundColor: Colors.white);
     }catch(e){  //for flutter errors
Get.snackbar(('error msg'), e.toString(),backgroundColor: Colors.white);
     }
setState(() {
  isloading=false;
}); 
  }

  @override
  Widget build(BuildContext context) {
    return isloading? Center(child: CircularProgressIndicator(),):Scaffold(  //means if loading is true then loading icon show hoga else scaffold
      backgroundColor: Colors.white,
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
              overflowSpacing:35, //set space of 20 between all the widgets present in it
              children: [
                TextFormField(
                  controller: email,
                  cursorColor: Color.fromRGBO(0, 80, 90, 1),
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
                  cursorColor: Colors.green,
                  obscureText: _obsecureText,
                  decoration:  InputDecoration(
                    labelText:'Password',
                    prefixIcon: Icon(Icons.password_sharp),
                    prefixIconColor: Color.fromRGBO(0, 80, 90, 1),
                    suffixIcon: IconButton(onPressed:_toggglePasswordVisibility,
                        icon: Icon(_obsecureText ? Icons.visibility_off:Icons.visibility)
                    ),
                    suffixIconColor:Color.fromRGBO(0, 80, 90, 1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 10, 90, 1),width: 3),
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
                Text('Don\'t have an account?'),
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

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     TextButton(
                        child: const Text('Forget password?',style: TextStyle(color: Color.fromRGBO(0, 80, 90, 1),fontSize: 20),),
                        onPressed: (){
                          Get.to(()=>Forgot());
                        },
                      ),

                     Container(
                         margin: EdgeInsets.all(16.0),
                       child: Center(
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             minimumSize: Size(200, 50), // Set the desired minimum size
                           ),
                           child: const Text('SignUp with phone Number',style: TextStyle(color: Color.fromRGBO(0, 80, 90, 1),fontSize: 16),),
                           onPressed: (){
                             Get.to(()=>PhoneScreen());
                           },
                         ),
                       ),
                     ),
                     Center(
                       child: ElevatedButton(
                         child: Text('Login with GOOGLE',style: TextStyle(color: Color.fromRGBO(0, 80, 90, 1),fontSize: 17),),
                         style: ElevatedButton.styleFrom(
                           minimumSize: Size(230, 50), // Set the desired minimum size
                         ),
                         onPressed: (){
                           Get.to(()=>google_signIn());
                         },
                       ),
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