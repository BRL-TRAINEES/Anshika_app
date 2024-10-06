
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

 bool isloading =false;
  signup()async{
    setState(() {
      isloading=true;
    });
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
      Get.offAll(Wrapper() as Widget Function());
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
                cursorColor: Colors.orange,
                validator: (value){
                  if(value==null)
                  {
                    return 'Please enter your email';
                  }
                  if (!value.contains('.')||!value.contains('@')) {
                    return 'Please enter a valid email';

                  }
                  return null;
                },
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
                  if(value==null)
                  {
                    return 'Please enter your password';
                  }
                  if (value.length<8) {
                    return 'Minimum 8 characters required';

                  }
                  if(!RegExp(r'[A-Z]').hasMatch(value)){
                    return 'Password requires atleast one uppercase letter';
                  }
                  if (!RegExp(r'[a-z]').hasMatch(value)) {
                    return 'Password must contain atleast one lowercase letter';
                  }
                  if (!RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password must contain at least one digit';

                  }
                  if (!RegExp('[!@#%\$^&*(),.?":{}|<>]').hasMatch(value)) {
                    return 'Password must contain at least one special character';
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
                  onPressed:signup,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
