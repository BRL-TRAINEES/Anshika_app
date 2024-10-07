
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController email= TextEditingController();
  TextEditingController password = TextEditingController();

  String passwordStrength = '';

  void checkPasswordStrength(String password) {

    if (password.length > 8 || (password.length > 6 &&
        RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password) &&
        RegExp(r'[A-Z]').hasMatch(password))) {
      setState(() {
        passwordStrength = 'Strong Password';
      });
    } else {
      setState(() {
        passwordStrength = 'Weak Password!';
      }
      );
    }
  }
    signup() async {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      Get.offAll(()=>Wrapper());
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Sign Up' , style: TextStyle(color: Colors.white),),
      ),
      body: Center(
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
                cursorColor: Colors.orange,
                decoration:  InputDecoration(
                  labelText:'Email ID',
                  prefixIcon: Icon(Icons.email_sharp),
                  prefixIconColor: Colors.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,width: 3),
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),

              TextFormField(
                controller: password,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'Please Enter valid password';
                  }
                  return null;
                },
                decoration:  InputDecoration(
                  hintText:'Password',
                  prefixIcon: Icon(Icons.password_rounded),
                  prefixIconColor: Colors.orange,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange,width: 3),
                      borderRadius: BorderRadius.circular(8)
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),),
                  onPressed:(()=>signup()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
