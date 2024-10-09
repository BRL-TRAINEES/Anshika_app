

// error msg aa hi rha h chhae sign up new id se ho yaaa purene se hi , valid mail,password dalne h

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Verify.dart';
import 'Login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController email= TextEditingController();
  TextEditingController password = TextEditingController();

  bool _obsecureText =true;


  void  _togglePasswordVisibility(){
    setState(() {
      _obsecureText  = !_obsecureText;
    });
  }
  
 bool isloading = false;

    signIn() async {
      setState(() {
        isloading = true;
      });
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text); //jaise hi yha login hua wrapper me stream changes observe krega toh snapshot aaygaa then abh snapshot pe data h toh hum homePage show krenge
      Get.offAll(()=>Verify());
    }on FirebaseAuthException catch(e){  //for firebase auth errors
      Get.snackbar("error msg",e.code,backgroundColor: Colors.white);
    }catch(e){  //for flutter errors
      Get.snackbar(('error msg'), e.toString(),backgroundColor: Colors.white);
    }
        setState(() {
          isloading = false;
        });
    }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Sign Up' , style: TextStyle(color: Colors.white),),
        ),
        body: isloading
            ? Center(
          child: CircularProgressIndicator(),
        )
            :Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),

            child: OverflowBar(
              overflowSpacing:40, //set space of 20 between all the widgets present in it
              children: [
                TextFormField(
                  controller: email,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter valid Email';
                    }
                    return null;
                  },
                  cursorColor: Colors.blue,
                  decoration:  InputDecoration(
                    labelText:'Email ID',
                    prefixIcon: Icon(Icons.email_sharp),
                    prefixIconColor: Colors.blue,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 3),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),

                TextFormField(
                  controller: password,
                  obscureText:_obsecureText,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter valid password';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    hintText:'Password',
                    
                    prefixIcon: Icon(Icons.password_rounded),
                    prefixIconColor: Colors.blue,
                    suffixIcon: IconButton(onPressed: _togglePasswordVisibility ,
                        icon: Icon(_obsecureText? Icons.visibility_off:Icons.visibility)
                    ),
                    suffixIconColor: Colors.blue,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue,width: 3),
                        borderRadius: BorderRadius.circular(8)
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),),
                    onPressed:(()=>signIn()),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('Already have an account? Sign up',style: TextStyle(color: Color.fromRGBO(0, 80, 90, 1),fontSize: 17),),
                      onPressed: (){
                        Get.to(()=>LoginPage());
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
