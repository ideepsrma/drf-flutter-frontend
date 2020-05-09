import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:drf_flutter/config/config.dart';

//------This page have------
//Check_login - if we have token - validate token
//Login - Generate token - save to shared_prefer - show details.
//Register


class UserProvider with ChangeNotifier {
  UserProvider() {
   check_login();
  }
  String userLogged = null;
  String auth_token = null;
  String login_button = "Sign In";
  String signup_button = "Sign Up";
  String login_response = null;
  String signup_response = null;
  String response_message = null;
  String signup_response_message = null;
  dynamic user_details = null;



  Future<dynamic> check_login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String auth_token = prefs.getString('auth_token');
  
  if(auth_token == null) {
    print("User not logged");
    userLogged = "0";
    notifyListeners();
  } else {
    userLogged = "1";
    notifyListeners();
    print("Validating auth token");
    final  response = await http.get('${APIurl}/user' , headers: {
    "Authorization" : "Token ${auth_token}"  
    });
    print(response.statusCode);
    if(response.statusCode == 200) {
      print("Logged");
      userLogged = "4";
      notifyListeners();
      user_Details(auth_token);
    } else {
      print("Not logged");
      userLogged = "2";
      notifyListeners();
    }
    // dynamic res = jsonDecode(response.body);
    // print(res['detail']);
  }
  }


  Future<dynamic> sign_in(String username, String password) async {
    login_response = null;
    login_button = "Loading..";
    notifyListeners();
    final response = await http.post("${APIurl}/api-token-auth" , body: {
    "username" : username,
    "password" : password
    });
    if(response.statusCode == 200) {
      login_button = "Sign In"; 
      login_response = "0";
      dynamic res = jsonDecode(response.body);
      response_message = res.toString();
      print(res["token"]);
      //Save token to sharedPref. for auto login
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("auth_token", res['token']);
      //And getting login details
      user_Details(res['token']);
    } else {
        dynamic res = jsonDecode(response.body);
      print(res);
      login_button = "Sign In";
      login_response = "1";
      response_message = res.toString();
      notifyListeners();
    }
    
    login_button = "Sign In";
    notifyListeners();
  }
  Future<dynamic> sign_up(String username, String password1, String password2 , String emailid, String firstname) async {
    signup_response = null;
    print(emailid);
    signup_button = "Loading..";
    notifyListeners();
    Map data = <dynamic, dynamic>{
       "username": username,
       "first_name": firstname,
       "last_name": "no",
       "email": emailid,
       "password": password2,
    };
    var body = json.encode(data);
    final response = await http.post("${APIurl}/register" , headers:{
    'Content-Type': "application/json",
    }, body: body);
 print(response.statusCode);
    if(response.statusCode == 201) {
      signup_button = "Sign Up"; 
      signup_response = "0";
      dynamic res = jsonDecode(response.body);
      signup_response_message = res.toString();
      sign_in(username, password2);
    } else {
      dynamic res = jsonDecode(response.body);
      print(res);
      signup_button = "Sign Up";
      signup_response = "1";
      signup_response_message = res.toString();
      notifyListeners();
    }
    
    signup_button = "Sign Up";
    notifyListeners();
  }

  Future<dynamic> user_Details(String auth_token) async {
    print("Getting user details");
    final response = await http.get('${APIurl}/user', headers: {
    "Authorization": "Token ${auth_token}"
    } );
    dynamic res = jsonDecode(response.body);
    user_details = res;
    print(user_details);
    print(res['message']);
    print(user_details['message']);
    notifyListeners();
    print(res);
  }

  Future<dynamic> logout() async {
    print("Log - Out");
    auth_token = null;
    login_response = null;
    response_message = null;
    print(auth_token);
    notifyListeners();
    check_login();
  }
  
  }