import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:location/location.dart';
import 'package:schoolapp/screens/login_screen.dart';
import 'package:schoolapp/widgets/banner_widget.dart';
import 'package:schoolapp/widgets/custom_appbar.dart';

import 'location_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? address = 'Pakistan';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),


          child: SafeArea(child: CustomAppbar())),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12,0,12,8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search,),
                            labelText: 'Find Schools',
                            labelStyle: TextStyle(fontSize: 12),
                            contentPadding: EdgeInsets.only(left: 10,right: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6)
                            )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.notifications_none),
                  SizedBox(width: 10,),


                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8 ),
            child: Column(
              children: [
                  BannerWidget(),
                ElevatedButton(onPressed: (){
                  FirebaseAuth.instance.signOut().then((value) {Navigator.pushReplacementNamed(context, LoginScreen.id);});
                }, child: Text('Sign out'))
              ],


            ),

          )
        ],
      ),

    );
  }
}
