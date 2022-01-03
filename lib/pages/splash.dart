import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/pages/login.dart';
import 'package:myapp/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    timer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        color: Colors.white,
        child: Text(
          "Sahara",
          style: TextStyle(fontSize: 35),
        ),
      )),
    );
  }

  void timer(BuildContext context) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var name = s.get("user");
    Timer(Duration(milliseconds: 1500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        if (name != null) {
          return Scaffold(body: Screen());
        } else {
          return Scaffold(body: Login());
        }
      }));
    });
  }

  void userInfo() async {}
}
