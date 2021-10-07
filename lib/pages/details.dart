import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/assests/icons.dart';
import 'package:myapp/components/details_topbar.dart';
import 'package:myapp/components/search_topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';
import 'package:myapp/pages/cart.dart';
import 'package:myapp/pages/categories.dart';
import 'package:myapp/pages/home.dart';

import 'account.dart';

class Details extends StatefulWidget {
  Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var pages = [Home(), Category(), Account(), Cart()];
  var states = [true, false, false, false];

  int current = 0;

  void change(int i) {
    switch (i) {
      case 0:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Home();
        }));
        break;
      case 1:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Category();
        }));
        break;
      case 2:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Account();
        }));
        break;
      case 3:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return Account();
        }));
        break;
    }
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
    return Scaffold(
        body: Column(
      children: [
        DetailsTopBar(),
        Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        color: primary,
                      ),
                    ],
                  ),
                )
              ],
            )),
      ],
    ));
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
