import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/assests/icons.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';
import 'package:myapp/pages/categories.dart';
import 'package:myapp/pages/search.dart';
import 'pages/home.dart';
import 'pages/account.dart';
import 'pages/cart.dart';

class Screen extends StatefulWidget {
  @override
  State<Screen> createState() {
    // TODO: implement createState
    return ScreenState();
  }
}

class ScreenState extends State<Screen> {
  var pages = [Home(), Category(), Account(), Cart(), Search()];

  var states = [true, false, false, false];

  ScreenState() {}

  int current = 0;

  void setSearch() {
    setState(() {
      current = 4;
    });
  }

  void change(int i) {
    setState(() {
      current = i;
      colorUpdate(i);
    });
  }

  void colorUpdate(int i) {
    var vs = states;
    for (var j = 0; j < states.length; j++) {
      if (j == i) {
        vs[j] = true;
      } else {
        vs[j] = false;
      }
    }
    setState(() {
      states = vs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.90,
          child: current < 4
              ? Column(children: [TopBarSecondary(setSearch), pages[current]])
              : pages[current],
        ),
        BottomNav()
      ],
    );
  }

  Widget BottomNav() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      color: primary,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeIcon(),
            CategIcon(),
            AccountIcon(),
            CartIcon(),
          ],
        ),
      ),
    );
  }

  Widget HomeIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[0] ? itemSelected : item,
        height: 5,
        width: 30,
      ),
      IconButton(
        color: iconColor,
        iconSize: 30,
        icon: homeIcon,
        onPressed: () => {change(0)},
      ),
    ]);
  }

  Widget CategIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[1] ? itemSelected : item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        color: iconColor,
        icon: categIcon,
        onPressed: () => {change(1)},
      ),
    ]);
  }

  Widget AccountIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[2] ? itemSelected : item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        color: iconColor,
        icon: accountIcon,
        onPressed: () => {change(2)},
      ),
    ]);
  }

  Widget CartIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[3] ? itemSelected : item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        icon: cartIcon,
        color: iconColor,
        onPressed: () => {change(3)},
      ),
    ]);
  }
}
