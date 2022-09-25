


import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SharedPreferences Demo',
      home: SharedPreferencesDemo(),
    );
  }
}

class SharedPreferencesDemo extends StatefulWidget {
  const SharedPreferencesDemo({Key? key}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();



  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();



  @override
  void initState() {
    super.initState();
    initialGetSaved();
  }



  void storeUserData() async{
    final SharedPreferences prefs = await _prefs;
    //store the user entered data in user object
    User user1 = User(_email.text, _password.text);
    // encode / convert object into json string
    String user = jsonEncode(user1);

    //save the data into sharedPreferences using key-value pairs
   prefs.setString('userdata', user);

  }


  void initialGetSaved() async{

    final SharedPreferences prefs = await _prefs;
    // Read the data, decode it and store it in map structure
    Map<String,dynamic> jsondatais = jsonDecode(prefs.getString('userdata')!);
    // convert it into User object
    var user = User.fromJson(jsondatais);
    if(jsondatais.isNotEmpty){

      //set the sharedPreferences saved data to TextField
      _email.value =  TextEditingValue(text: user.email);
      _password.value =  TextEditingValue(text: user.password);

    }

  }


  var list = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('shared preferences '),),
        body: Container(
          margin: const EdgeInsets.only(left: 20,right: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                    hintText: 'email',
                    border: OutlineInputBorder(

                    ),),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _password,
                decoration: const InputDecoration(
                    hintText: 'password',
                    border: OutlineInputBorder()),),
              ElevatedButton(onPressed: ()async{
                storeUserData();
              }, child: const Text('press me'))
            ],
          ),
        )
    );
  }
}







class User {
  final String email;
  final String password;
  User(this.email, this.password,);
  //constructor that convert json to object instance
  User.fromJson(Map<String, dynamic> json) : email = json['email'],  password = json['password'];
  //a method that convert object to json
  Map<String, dynamic> toJson() => {

    'email': email,
    'password':password
  };
}