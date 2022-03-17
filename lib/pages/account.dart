import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar_secondary.dart';
import 'package:myapp/pages/Address.dart';
import 'package:myapp/pages/orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Account extends StatefulWidget {
  StatefulWidget TopBar;

  Account(StatefulWidget this.TopBar);
  @override
  State<Account> createState() {
    // TODO: implement createState
    return AccountState(TopBar);
  }
}

class AccountState extends State<Account> {
  StatefulWidget TopBar;

  AccountState(StatefulWidget this.TopBar) {}

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TopBar,
      Expanded(
        flex: 2,
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
              child: Container(
            child: layout(),
          ))
        ]),
      )
    ]);
  }

  Future<void> logout() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }

  Future<bool> islogged() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    return s.containsKey("user");
  }

  void login() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }

  Widget notLogged() {
    return Container(
      width: double.infinity,
      height: 600,
      color: inner,
      child: Center(
        child: MaterialButton(
          color: Colors.black,
          onPressed: () {
            login();
          },
          child: Container(
            child: Center(
                child: Text(
              "Login",
              style: TextStyle(color: Colors.white),
            )),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85,
          ),
        ),
      ),
    );
  }

  Future<String?> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name");
  }

  Widget layout() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 700,
          color: inner,
          child: Column(
            children: [
              Container(
                  height: 150,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: innerDark,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      FutureBuilder(
                        future: getName(),
                        builder: (context, snap) {
                          if (snap.hasData) {
                            return RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    children: [
                                  TextSpan(
                                      text: snap.data.toString().toUpperCase(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]));
                          } else {
                            return Text("");
                          }
                        },
                      )
                    ],
                  )),
              getSub(context, "Orders", Orders()),
              getSub(context, "Address", Address()),
            ],
          ),
        ),
        MaterialButton(
          color: Colors.black,
          onPressed: () {
            logout();
          },
          child: Container(
            child: Center(
                child: Text(
              "Logout",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
            height: 50,
            width: MediaQuery.of(context).size.width * 0.85,
          ),
        ),
      ],
    );
  }
}

void move(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return page;
  }));
}

Widget getSub(BuildContext context, String text, Widget page) {
  return GestureDetector(
    onTap: () => move(context, page),
    child: Container(
      height: 70,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: 16)),
          Icon(Icons.arrow_right_outlined)
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
    ),
  );
}
