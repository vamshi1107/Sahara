import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar_secondary.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() {
    // TODO: implement createState
    return AccountState();
  }
}

class AccountState extends State<Account> {
  AccountState() {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 200,
          color: inner,
        ));
  }
}
