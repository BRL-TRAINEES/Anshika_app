import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form/pages/Home.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:form/pages/PhoneNumber.dart';

class OtpPage extends StatefulWidget {

  final String vid;
  const OtpPage({super.key,required this.vid});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  var code ='';

  SignIn()async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.vid,  // to get the value of string vid
        smsCode: code,
    );
    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((value)=>{
        Get.offAll(()=>Home()),
      });
    }on FirebaseAuthException catch(e){
      Get.snackbar('Error', e.code,backgroundColor: Colors.white);
    }catch(e){
      Get.snackbar('Error', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('OTP'),
      ),
      body: Center(
        child: Column(
          children: [
            Pinput(
              length: 6,
              onChanged: (value){
                setState(() {
                  code=value;  // storing the value that user provides in code
                });
              },
            ) ,
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                onPressed:SignIn,
                child: Text('Verify & Proceed'))
          ],
        ),
      ),
    );
  }
}
