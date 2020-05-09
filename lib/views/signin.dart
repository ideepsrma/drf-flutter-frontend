import 'package:drf_flutter/provider/user_provider.dart';
import 'package:drf_flutter/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  TextEditingController loginUsernameController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
          child: Scaffold(
            bottomNavigationBar: InkWell(
              onTap: () {
              Provider.of<UserProvider>(context).sign_in(loginUsernameController.text, loginPasswordController.text);
              },
              child: Container(
                height: 60,
                color: Colors.green,
                child: Center(
                  child:Consumer<UserProvider>(builder: (_, user , __)=>  Text(user.login_button, textAlign: TextAlign.center,
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
              (
                padding: EdgeInsets.only(top:90, right: 40.0, left: 40.0),
               child:              Hero(
             tag: "signin",
            child: Text("Sign In" , textAlign: TextAlign.center, style: TextStyle(color: Colors.black,
              fontSize: 25
              ),),
              )
                ),
            ),
           sign_in_form()
          ],
        )
    
      ),
    );
  }
  Widget sign_in_form(){
    return   Container(
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
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: loginUsernameController,
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
                    Container(
                      color: Color(0xfff5f5f5),
                      child: TextFormField(
                        controller: loginPasswordController,
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
                    Consumer<UserProvider>(builder: (_, user , __)=> 
                    user.login_response == "0" ? Container(
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
                          Text("Logged:\nResponse from Server:" , textAlign: TextAlign.left, style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600)),
                          Text(user.response_message.toString()),
                          InkWell(
                            onTap: (){
                                Navigator.push<dynamic>(context,
                           MaterialPageRoute<dynamic>(builder: (context) => DashBoard()));
                            },
                            child: Text("GO TO DASHBOARD" , style: TextStyle(color: Colors.blue),))
                        ],
                      ),
                    )
                   : user.login_response == "1"? Container(
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
                          Text(user.response_message.toString()),
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
                      child: Text("STEPS:\n*DRF check login details , if they are valid then generate a token and save it to sharedPrefs for AutoLogin \n*We Printing response here to provide what we are getting from server"),
                    )
                     ],
                ),
              ),
            );
        
  }
}