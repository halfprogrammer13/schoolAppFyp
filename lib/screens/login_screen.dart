import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/screens/location_screen.dart';

import '../widgets/auth_ui.dart';


class LoginScreen extends StatelessWidget {
  static const String id = 'login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.cyan.shade900,
      body:Column(
        children: [
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 100,),
                Image.asset('assets/images/logo.png',height: 100,width: 100,),
                SizedBox(height: 10,),
                Text('School Finder',style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan
                ),)
              ],
            ),
          )),
          
          
          Expanded(child: Container(
            child: AuthUi(),
          ))

        ],
      ),
    );
  }
}
