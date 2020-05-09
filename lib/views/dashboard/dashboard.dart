import 'dart:io';

import 'package:drf_flutter/provider/user_provider.dart';
import 'package:drf_flutter/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
   DateTime currentBackPressTime;

   void log_out() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Provider.of<UserProvider>(context).logout();
    await Navigator.push<dynamic>(context,
    MaterialPageRoute<dynamic>(builder: (context) => Splash_screen()));
               
   } 
   
  @override
  Widget build(BuildContext context) {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit an App'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        bottomNavigationBar: InkWell(
              onTap: () {
              log_out();
               },
              child: Container(
                height: 60,
                color: Colors.red,
                child: Center(
                  child: Text("LOGOUT", textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),)
              ),
            ),
          
      body: CustomScrollView(
       slivers: <Widget>[
         SliverAppBar(
           centerTitle: true,
           pinned: true,
           backgroundColor: Colors.white,
           title: Text("DASHBOARD" , style: TextStyle(color: Colors.blueGrey),),
         ),
         Consumer<UserProvider>(builder: (_, user , __)=>
         user.user_details == null ? SliverToBoxAdapter(
         child: Container(
           height: 200,
           child: Center(child: Text("Loading")))
         ) : SliverToBoxAdapter(
         child: Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Container(
                 width: MediaQuery.of(context).size.width,
               color: Colors.grey[200],
               height: 200,
               child: Center(
                 child: Text("Hi ! \n${user.user_details['FirstName']}", style: TextStyle(color: Colors.black,
                 fontSize: 18
                 ),),
               ),
               ),
                 Divider(),
                  Text("Username:" , style: TextStyle(color: Colors.black87 , ),),
                  Text(user.user_details['User Name'] , style: TextStyle(color: Colors.blueGrey , )),
                 Divider(),
                  Text("Email:" , style: TextStyle(color: Colors.black87 , ),),
                  Text(user.user_details['Email'] , style: TextStyle(color: Colors.blueGrey , )),
                 Divider(),
                  Text("Last Name:" , style: TextStyle(color: Colors.black87 , ),),
                  Text(user.user_details['LastName'] , style: TextStyle(color: Colors.blueGrey , )),
              

             ],
           ),
         ),
         ),
         )
       ], 
      ),
      ),
     );
  }
}