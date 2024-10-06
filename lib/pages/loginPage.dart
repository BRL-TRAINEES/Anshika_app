import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();  //that validates the saves the form
 TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  void logIn()async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.text, password: _password.text); //jaise hi yha login hua wrapper me stream changes observe krega toh builder me snapshot aaygaa then abh snapshot pe data h toh hum homePage show krenge
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  controller: _email,
                  cursorColor: Colors.green,
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
                    prefixIconColor: Color.fromRGBO(0, 80, 90, 1),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(0, 80, 90, 1),width: 3),
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),

                TextFormField(
                  controller: _password,
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
                // SizedBox(
                //   width: double.infinity,
                //   height:
                //   55,
                //
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color.fromRGBO(0, 80, 90, 1),
                //     ),
                //     child: const Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 20),),
                //     onPressed:loginIn,
                //   ),
                //   ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
