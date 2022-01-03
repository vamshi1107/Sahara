import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:myapp/api/client.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _name = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Sign up",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 45,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w300),
                )),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 50),
          ),
          Container(
            child: Column(
              children: [
                getFeild("Name", _name, false),
                getFeild("Username", _username, false),
                getFeild("Password", _password, true),
                Container(
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      signUser();
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Create",
                        style: TextStyle(color: Colors.white),
                      )),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getFeild(String name, TextEditingController controller, bool obscure) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: obscure,
          decoration:
              InputDecoration(hintText: name, border: OutlineInputBorder())),
    );
  }

  void signUser() async {
    String name = _name.text.toString();
    String user = _username.text.toString();
    String pass = _password.text.toString();
    var api = API();
    api.userSignup({"name": name, "user": user, "pass": pass}).then((value) {
      if (value) {
        showSnackbar("Signup successfull", Colors.black);
        Navigator.pop(context);
      } else {
        showSnackbar("Unable to signup", Colors.red);
      }
    });
  }

  void showSnackbar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        child: Text(msg),
      ),
      backgroundColor: color,
    ));
  }
}
