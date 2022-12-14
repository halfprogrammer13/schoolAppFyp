import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/authentication/otp_screen.dart';
import 'package:schoolapp/screens/location_screen.dart';

class PhoneAuthService {


  FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> addUser(context)async{

    final result = await users.where('uid',isEqualTo: FirebaseAuth.instance.currentUser?.uid).get();

    List<DocumentSnapshot> document = result.docs;

    if(document.length>0){
      Navigator.pushReplacementNamed(context, LocationScreen.id);
    }else{
      return users.doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'uid':FirebaseAuth.instance.currentUser?.uid,
        'mobile':FirebaseAuth.instance.currentUser?.phoneNumber,
        'email':FirebaseAuth.instance.currentUser?.email

      }).then((value) {
        Navigator.pushReplacementNamed(context, LocationScreen.id);
      })
          .catchError((error)=>print('Failed to add user : ${error}'));
    }

  }




  Future<void> verifyPhoneNumber(BuildContext context,number) async {
    final PhoneVerificationCompleted verificationCompleted= (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException e){
      if(e.code=='invalid-phone-number'){
        print('The provided phone number is not valid');
      }
      print('The error is ${e.code}');
    };

   final PhoneCodeSent codeSent = (String verId, int? resendToken)async {
  Navigator.push(context, MaterialPageRoute(builder: (context)=>OTPScreen(number: number,verId:verId)));
   };

   try {
     auth.verifyPhoneNumber(phoneNumber: number,
         verificationCompleted: verificationCompleted,
         verificationFailed: verificationFailed,
         codeSent: codeSent,
         timeout: const Duration(seconds: 60),

         codeAutoRetrievalTimeout: (String verificationId) {
           print(verificationId);
         });
   }catch(e){
     print('Error${e.toString()}');
   }
  }
}
