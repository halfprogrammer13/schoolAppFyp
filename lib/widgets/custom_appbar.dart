import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/services/firebase_service.dart';

import '../screens/location_screen.dart';


class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseService _service = FirebaseService();


    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(FirebaseAuth.instance.currentUser?.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Address not selected");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

          if(data['address']==null){
            GeoPoint latlong = data['location'];
            _service.getAddress(latlong.latitude, latlong.longitude).then((adres) {
              return appBar(adres, context);
            });
          }else{
            return appBar(data['address'], context);
          }

        }

        return Text("Fetching Location...");
      },
    );
  }

  Widget appBar(address, context){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: InkWell(
        onTap: (){
          Navigator.pushNamed(context, LocationScreen.id);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
              children: [
                Icon(CupertinoIcons.location_solid,color: Colors.black,size: 18,),


                Text(address!,style: TextStyle(
                  color: Colors.black,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,


                ),),

                // Icon(Icons.arrow_downward_outlined,color: Colors.black,),


              ]
          ),
        ),
      ),
    );
  }
}


