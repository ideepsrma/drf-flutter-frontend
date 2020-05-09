import 'dart:async';
import 'package:drf_flutter/widgets/checking_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_screen extends StatefulWidget {
  @override
  _Splash_screenState createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {

Widget _flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext, 
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(style: DefaultTextStyle.of(toHeroContext).style,
  
   child: toHeroContext.widget);
}
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: 500,
             decoration: new BoxDecoration(
                gradient: new LinearGradient(
                      colors: [
                           Colors.yellowAccent[100],
                           Colors.green,
                      ],
                      begin: const FractionalOffset(1.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: checking_login(context)
           ),
          Positioned(
            top: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Django REST framework \nWith Flutter" , 
              style: TextStyle(color: Colors.black54, fontSize: 25,
                      fontWeight: FontWeight.w800
                      )),
            )),
          Positioned(
            bottom: 10,
            child:
          Text("LOGIN, AUTH-TOKEN, SIGNUP, EDIT" , style: TextStyle(fontSize: 11, color: Colors.white , fontWeight: FontWeight.w500),) )
         
        ],
      
        
          ),
    );
  }
}