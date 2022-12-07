import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/location_screen.dart';
import 'package:schoolapp/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id ='splash-screen';
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
        Timer(Duration(seconds: 3), () {
          FirebaseAuth.instance.authStateChanges().listen(( user) {
            if(user==null){
              Navigator.pushReplacementNamed(context, LoginScreen.id);
            }else{
              Navigator.pushReplacementNamed(context, LocationScreen.id);

            }
          });

        });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.white,
      Colors.grey,

    ];


    const colorizeTextStyle = TextStyle(
      fontSize: 30.0,
      fontFamily: 'Lato',
    );





    return Scaffold(
      backgroundColor: Colors.cyan,
      body:Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),

            Image.asset('assets/images/logo.png',height: 100,width: 100,),
        AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'School Finder',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),

          ],
          isRepeatingAnimation: true,
          onTap: () {
            print("Tap Event");
          },
        )

        ],
        ),
      )
    );
  }
}
