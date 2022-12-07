import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/services/phoneauth_service.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class PhoneAuthScreen extends StatefulWidget {
  static const String id = 'phone-auth-screen';
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  bool validate = false;
  var countryCodeController = TextEditingController(text: '+92');
  var phoneNumberController = TextEditingController();


  PhoneAuthService _service = PhoneAuthService();



  String counterText = '0';
  @override
  Widget build(BuildContext context) {
    SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(context: context, barrierDimisable:  false);

    void showDialog() async{
      _dialog.show(message: 'Please Wait');
      await Future.delayed(Duration(seconds: 1));
      _dialog.hide();
    }


    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.red.shade200,
              child: Icon(
                CupertinoIcons.person_alt_circle,
                color: Colors.red,
                size: 60,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Enter your phone',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'We will send confirmation  code to your phone',
              style: TextStyle(color: Colors.grey),
            ),
            Row(
              children: [
                Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: countryCodeController,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                    )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                      onChanged: (value) {
                        if (value.length == 10) {
                          setState(() {
                            validate = true;
                          });
                        }
                        if (value.length < 10) {
                          setState(() {
                            validate = false;
                          });
                        }
                      },
                      autofocus: true,
                      maxLength: 10,
                      keyboardType: TextInputType.phone,
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 22, bottom: 22),
                          labelText: 'Number',
                          hintText: 'Enter your phone number',
                          hintStyle:
                              TextStyle(fontSize: 10, color: Colors.grey))),
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AbsorbPointer(
            absorbing: validate ? false : true,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: validate
                    ? MaterialStateProperty.all(Theme.of(context).primaryColor)
                    : MaterialStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                String number =
                    '${countryCodeController.text}${phoneNumberController.text}';

                _service.verifyPhoneNumber(context, number);
                showDialog();

              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



