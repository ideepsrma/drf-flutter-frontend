import 'package:drf_flutter/provider/user_provider.dart';
import 'package:drf_flutter/views/dashboard/dashboard.dart';
import 'package:drf_flutter/views/signin.dart';
import 'package:drf_flutter/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget checking_login(dynamic context){
return Consumer<UserProvider>(builder: (_, user , __)=> 
                user.userLogged == null ? show_loading("Loading.." , context) :
                user.userLogged == "0" ? show_loading("", context) :
                user.userLogged == "1" ? show_loading("Validating auth token..", context) :
                user.userLogged == "2" ? show_loading("Token is not valid..", context) :
                 user.userLogged == "4" ? show_loading("Token Valid", context) :
                Text("Error")

);
}

//Check what is happening in background
Widget show_loading(String text , dynamic context) {
return Container(
  margin: EdgeInsets.only(top: 330),
  child: Column(
    children: <Widget>[
        Divider(),
        show_button(context),
        Text(text , style: TextStyle(fontWeight: FontWeight.w500 , color: Colors.deepOrange[400],
      fontSize: 18
      ),),
     // Divider(),
    ],
  )
  
);
}

//Decide To Show Button
Widget show_button(dynamic context) {
return Consumer<UserProvider>(builder: (_, user , __)
               => user.userLogged == null ? Text("") :
               user.userLogged == "2" ? login_signup_button(context) :
               user.userLogged == "0" ? login_signup_button(context) :
               user.userLogged == "4" ? dashboard_button(context) :
               Text("")
);
}
Widget dashboard_button(dynamic context) {
  return RaisedButton(
               color: Colors.white70,
               elevation: 0.0,
               onPressed: (){
                           Navigator.push<dynamic>(context,
                           MaterialPageRoute<dynamic>(builder: (context) => DashBoard()));
                            },
               child: Padding(
               padding: const EdgeInsets.only(left: 10.0, right: 10 , top: 10, bottom: 10),
               child: Text("Go To Dashboard")),);
     
}
//Login Sign-up Buttons
Widget login_signup_button(dynamic context) {
return Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
children: <Widget>[

             Hero(  
               tag: "signin",
               flightShuttleBuilder: _flightShuttleBuilder,
               child: RaisedButton(
               color: Colors.white70,
               elevation: 0.0,
               onPressed: (){
                           Navigator.push<dynamic>(context,
                           MaterialPageRoute<dynamic>(builder: (context) => SignIn()));
                            },
               child: Padding(
               padding: const EdgeInsets.only(left: 10.0, right: 10 , top: 10, bottom: 10),
               child: Text("Sign In")),) ,
     ),
             Hero(  
               tag: "signup",
               flightShuttleBuilder: _flightShuttleBuilder,
               child: RaisedButton(
               color: Colors.white70,
               elevation: 0.0,
               onPressed: (){
                           Navigator.push<dynamic>(context,
                           MaterialPageRoute<dynamic>(builder: (context) => SignUp()));
                            },
               child: Padding(
               padding: const EdgeInsets.only(left: 10.0, right: 10 , top: 10, bottom: 10),
               child: Text("Sign Up")),) ,
     ),
     
],
);
}



//This is for HeroAnimation
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
  