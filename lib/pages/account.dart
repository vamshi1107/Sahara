import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar_secondary.dart';
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
                  width: double.infinity,
                  color: inner,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 600,
                        color: inner,
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
                            style: TextStyle(color: Colors.white),
                          )),
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.85,
                        ),
                      ),
                    ],
                  ))),
        ]),
      )
    ]);
  }

  Future<void> logout() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.remove("username");
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return Login();
      },
    ));
  }
}
