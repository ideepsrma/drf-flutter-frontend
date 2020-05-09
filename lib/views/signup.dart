import 'package:drf_flutter/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController signupUsernameController = new TextEditingController();
  TextEditingController signupPassword1Controller = new TextEditingController();
  TextEditingController signupPassword2Controller = new TextEditingController();
  TextEditingController signupFirstNameController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Material(
      type: MaterialType.transparency,
          child: Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {
             Provider.of<UserProvider>(context).sign_up(signupUsernameController.text, signupPassword1Controller.text, signupPassword2Controller.text, signupEmailController.text, signupFirstNameController.text);
              },
              child: Container(
                height: 60,
                color: Colors.green,
                child: Center(
                  child:Consumer<UserProvider>(builder: (_, user , __)=>  Text(user.signup_button, textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white)),
                ),)
              ),
            ),
            body:     Stack(
              
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: BoxDecoration(
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
              child: Padding
              (padding: EdgeInsets.only(top:90, right: 40.0, left: 40.0),
               child:Hero(
               tag: "signup",
               child: Text("Sign Up" , textAlign: TextAlign.center, style: TextStyle(color: Colors.black,
              fontSize: 25
              ),),
              )
                ),
            ),
            sign_up_form(),
            ],
        )
    
      ),
    );
 
  }
  Widget sign_up_form(){
    return  Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(23),
                child: ListView(
                  children: <Widget>[
                   // Text("msg" , style: TextStyle(color: Colors.redAccent, ),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: signupUsernameController,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(
                              fontSize: 15
                            )
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: signupFirstNameController,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'First Name',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(
                              fontSize: 15
                            )
                          ),
                        ),
                      ),
                    ),
                   Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: signupEmailController,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Id',
                            prefixIcon: Icon(Icons.person_outline),
                            labelStyle: TextStyle(
                              fontSize: 15
                            )
                          ),
                        ),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: signupPassword1Controller,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            labelStyle: TextStyle(
                                fontSize: 15
                              )
                          ),
                        ),
                      ),
                    ),
                   Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: signupPassword2Controller,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SFUIDisplay'
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirm Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            labelStyle: TextStyle(
                                fontSize: 15
                              )
                          ),
                        ),
                      ),
                    ),
                  
                  
                    Consumer<UserProvider>(builder: (_, user , __)=> 
                    user.signup_response == "0" ? Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                         color: Colors.green 
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Sign Up DONE:\nResponse from Server:" , textAlign: TextAlign.left, style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                          Text(user.signup_response_message.toString()),
                          InkWell(
                            onTap: (){
                                Navigator.push<dynamic>(context,
                           MaterialPageRoute<dynamic>(builder: (context) => DashBoard()));
                            },
                            child: Text("GO TO DASHBOARD" , style: TextStyle(color: Colors.blue),))
                        ],
                      ),
                    )
                   : user.signup_response == "1"? Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                         color: Colors.red 
                        )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Error:\nResponse from Server:" , textAlign: TextAlign.left, style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                          Text(user.signup_response_message.toString()),
                        ],
                      ),
                    )
                   : Text("") ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[200]
                        )
                      ),
                      child: Text("STEPS: \nPosting data to server , on signup confirm  app auto generate auth-token a logged you \n*We Printing response here to provide what we are getting from server"),
                    )
                     ],
                ),
              ),
            );
         
  }
}