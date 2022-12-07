import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/authentication/email_auth_screen.dart';
import 'package:schoolapp/screens/authentication/phoneauth_screen.dart';
import 'package:schoolapp/screens/home_screen.dart';
import 'package:schoolapp/screens/location_screen.dart';
import 'package:schoolapp/screens/login_screen.dart';
import 'package:schoolapp/screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan.shade900,
            fontFamily: 'Lato'
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
        LocationScreen.id: (context) => LocationScreen(),
        EmailAuthScreen.id: (context) => EmailAuthScreen(),




      },



    );




    // return FutureBuilder(
    //   // Replace the 3 second delay with your initialization code:
    //   future: Future.delayed(Duration(seconds: 3)),
    //   builder: (context, AsyncSnapshot snapshot) {
    //     // Show splash screen while waiting for app resources to load:
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           theme: ThemeData(
    //               primaryColor: Colors.cyan.shade900,
    //               fontFamily: 'Lato'
    //           ),
    //
    //
    //           home: SplashScreen());
    //     } else {
    //       // Loading is done, return the app:
    //       return MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         theme: ThemeData(
    //             primaryColor: Colors.cyan.shade900, fontFamily: 'Lato'),
    //         home: LoginScreen(),
    //         routes: {
    //           LoginScreen.id: (context) => LoginScreen(),
    //           PhoneAuthScreen.id: (context) => PhoneAuthScreen(),
    //           LocationScreen.id: (context) => LocationScreen(),
    //
    //         },
    //       );
    //     }
    //   },
    // );
  }
}
