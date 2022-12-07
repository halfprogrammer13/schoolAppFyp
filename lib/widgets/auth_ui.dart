import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:schoolapp/screens/authentication/phoneauth_screen.dart';

import '../screens/authentication/email_auth_screen.dart';


class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: (){
                  Navigator.pushNamed(context, PhoneAuthScreen.id);
                }, child: Row(
              children: [
                Icon(Icons.phone_android_outlined,color: Colors.black,),
                SizedBox(width: 8,),
                Text('Continue with Phone',style: TextStyle(
                  color: Colors.black
                ),)
              ],
            )),
          ),

          SignInButton(

              Buttons.Google,
              text: ('Continue with Google'),
              onPressed: (){}),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('OR',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),),
          ),

        InkWell(
          onTap: (){
            Navigator.pushNamed(context, EmailAuthScreen.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text('Login with Email',style: TextStyle(color:Colors.white,fontSize: 18),),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white))
              ),
            ),
          ),
        )


        ],
      ),
    );
  }
}
