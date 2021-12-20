import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text("Login",
                style: GoogleFonts.poppins(
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
                getFeild("Username", _username, false),
                getFeild("Password", _password, true),
                Container(
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.grey[100],
                    onPressed: () {
                      logUser();
                    },
                    child: Container(
                      child: Center(
                          child: Text("Login",
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: Colors.black),
                                fontSize: 16,
                              ))),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Colors.black,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Signup();
                      }));
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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

  void logUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String user = _username.text.toString();
    String pass = _password.text.toString();
    if (user.length > 4 && pass.length > 6) {
      pref.setString("username", user);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return Scaffold(
          body: Screen(),
        );
      }));
    }
  }
}
