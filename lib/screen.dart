import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/assests/icons.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_main.dart';
import 'package:myapp/pages/buy.dart';
import 'package:myapp/pages/categories.dart';
import 'package:myapp/pages/lottie_animation.dart';
import 'package:myapp/pages/search.dart';
import 'package:myapp/states/CurrentPage.dart';
import 'package:provider/provider.dart';
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
  var states = [true, false, false, false];
  ScreenState() {}

  void setSearch() {
    Provider.of<CurrentPage>(context).changePageNo(4);
  }

  void change(int i) {
    Provider.of<CurrentPage>(context, listen: false).changePageNo(i);
    setState(() {
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

  List<Widget> getPages() {
    return [
      Home(),
      Category(),
      Account(),
      Cart(),
      Search(),
      BuyPage(),
      LottieAnimation(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.90,
          child: getPages()[Provider.of<CurrentPage>(context).page],
          // child: IndexedStack(
          //   index: current,
          //   children: getPages(),
          // ),
        ),
        BottomNav()
      ],
    );
  }

  Widget BottomNav() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: double.infinity,
      color: AppColors.primary,
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
        color: states[0] ? AppColors.itemSelected : AppColors.item,
        height: 5,
        width: 30,
      ),
      IconButton(
        color: AppColors.iconColor,
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
        color: states[1] ? AppColors.itemSelected : AppColors.item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        color: AppColors.iconColor,
        icon: categIcon,
        onPressed: () => {change(1)},
      ),
    ]);
  }

  Widget AccountIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[2] ? AppColors.itemSelected : AppColors.item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        color: AppColors.iconColor,
        icon: accountIcon,
        onPressed: () => {change(2)},
      ),
    ]);
  }

  Widget CartIcon() {
    return Column(children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: states[3] ? AppColors.itemSelected : AppColors.item,
        height: 5,
        width: 30,
      ),
      IconButton(
        iconSize: 30,
        icon: cartIcon,
        color: AppColors.iconColor,
        onPressed: () => {change(3)},
      ),
    ]);
  }
}
