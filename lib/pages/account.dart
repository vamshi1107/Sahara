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
                child: FutureBuilder(
                  future: islogged(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == true) {
                        return layout();
                      } else {
                        return notLogged();
                      }
                    } else {
                      return notLogged();
                    }
                  },
                )),
          )
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

  Widget layout() {
    return Column(
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
    );
  }
}
