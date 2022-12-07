import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*.25,
          color: Colors.cyan,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10,),
                          Text('SCHOOLS',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 18
                          ),),
                          SizedBox(height: 20,),
                  SizedBox(
                    height: 45.0,
                    child: DefaultTextStyle(
                      style:  TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          FadeAnimatedText('Education for\n Everyone',duration: Duration(seconds: 4)),
                          FadeAnimatedText('New way to \n Find or add \nSchools',duration: Duration(seconds: 4)),
                          FadeAnimatedText('Find Best\n Schools near\n you!',duration:Duration(seconds: 4) ),
                        ],

                      ),
                    ),
                  )
                        ],
                      ),
                      Neumorphic(
                        style: NeumorphicStyle(
                          color: Colors.white
                        ),
                        child: Image.network('https://firebasestorage.googleapis.com/v0/b/schoolfinder-c2e87.appspot.com/o/banner%2Ficons8-school-100.png?alt=media&token=b049602a-567e-4dfd-8929-8d5874673754'),
                      )
                    ],
                  ),
                ),
                 Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Expanded(child: NeumorphicButton(
                       onPressed: (){},
                       style: NeumorphicStyle(color: Colors.white),
                       child: Text('Find School',textAlign: TextAlign.center),
                     )),
                     SizedBox(width: 20,),
                     Expanded(child: NeumorphicButton(
                       onPressed: (){},

                       style: NeumorphicStyle(color: Colors.white),

                       child: Text('Add School',textAlign: TextAlign.center,),
                     )),
                     
                   ],
                 )

              ],
            ),
          ),),
    );
  }
}
