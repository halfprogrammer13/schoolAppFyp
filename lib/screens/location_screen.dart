import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:location/location.dart';
import 'package:schoolapp/screens/home_screen.dart';
import 'package:schoolapp/screens/login_screen.dart';
import 'package:schoolapp/services/firebase_service.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  static const String id = 'location-screen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  FirebaseService _service = FirebaseService();

  bool _loading = false;
  Location? location = new Location();

  late bool _serviceEnabled;

  late PermissionStatus _permissionGranted;

  late LocationData _locationData;

  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  String manualAddress = "";

  Future<LocationData?> getLocation() async {
    _serviceEnabled = await location!.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location!.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location!.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location!.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location!.getLocation();

    final coordinates =
        new Coordinates(_locationData.latitude, _locationData.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;

    setState(() {
      address = first.addressLine;
      countryValue = first.countryName;
    });

    return _locationData;
  }

  @override
  Widget build(BuildContext context) {


    // _service.users
    //     .doc(FirebaseAuth.instance.currentUser?.uid)
    //     .get()
    //     .then((DocumentSnapshot document) {
    //   if (document.exists) {
    //       if(document['address']!=null){
    //         setState((){
    //           _loading = true;
    //         });
    //       }else{
    //         setState((){
    //           _loading = false;
    //         });
    //       }
    //   }
    // });






    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);





    void showDialog() async {
      _dialog.show(message: 'Fetching Location');
    }

    showBottomScreen(context) {
      getLocation().then((location) {
        if (location != null) {
          _dialog.hide();
          showModalBottomSheet(
              isScrollControlled: true,
              enableDrag: true,
              context: context,
              builder: (context) {
                return Column(
                  children: [
                    SizedBox(
                      height: 26,
                    ),
                    AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(color: Colors.black),
                      elevation: 1,
                      backgroundColor: Colors.white,
                      title: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.clear)),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Loaction',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Search City or Area',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        _dialog.show(message: 'Loading');

                        getLocation().then((value){
                          if(value!=null){
                            _service.updateUser({
                              'location':GeoPoint(value!.latitude!,value!.longitude!),
                              'address' :address,

                            }, context).then((value) {
                                _dialog.hide();
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                            });
                          }
                        });
                      },
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.my_location,
                        color: Colors.blue,
                      ),
                      title: Text(
                        'Use current Location',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        location == null ? 'Fetching Location' : address!,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 10, bottom: 4, top: 4),
                        child: Text(
                          'CHOOSE CITY',
                          style: TextStyle(
                              color: Colors.blueGrey.shade900, fontSize: 12),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: CSCPicker(
                        layout: Layout.vertical,
                        dropdownDecoration:
                            BoxDecoration(shape: BoxShape.rectangle),
                        defaultCountry: DefaultCountry.Pakistan,

                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            if (stateValue == "") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(('Select State'))));
                            }
                            setState(() {
                              cityValue = value;

                              manualAddress =
                                  '${cityValue},${stateValue},${countryValue}';
                            });

                            if (value != null) {
                              _service.updateUser({
                                'address': manualAddress,
                                'state': stateValue,
                                'city': cityValue,
                                'country': countryValue
                              }, context).then((value) {});
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height:40 ,),
                    ElevatedButton(
                      style: ButtonStyle(

                      ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                        child: Text('Select'))
                  ],
                );
              });
        } else {}
      });
    }




    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset('assets/images/location.jpg'),
            SizedBox(
              height: 20,
            ),
            Text(
              'Where do want\nto find/add school',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'For a better experience\n please select loaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: _loading
                        ? Center(
                            child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                          ))
                        : ElevatedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Theme.of(context).primaryColor)),
                            icon: Icon(CupertinoIcons.location_fill),
                            label: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Text(
                                'Around Me',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {

                              setState(() {
                                _loading = true;
                              });
                              getLocation().then((value) {

                                if (value != null) {
                                 _service.updateUser({
                                   'address': address,
                                   'location':GeoPoint(value!.latitude!,value!.longitude!),


                                 }, context);
                                 Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                                }});
                            },
                          ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                _dialog.show(message: 'Fetching Location...');
                showBottomScreen(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 2))),
                   child: Text(
                   'Set location Manually',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                   ),
                ),
              ),
            )
          ],
        ));
  }
}
