import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../components/topbar_main.dart';
import '../states/CurrentPage.dart';

class LottieAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LottieState();
  }
}

class LottieState extends State<LottieAnimation> {
  @override
  void initState() {
    super.initState();
    timer(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade100,
        child: Column(
          children: [
            TopBarMain(),
            Expanded(flex: 2, child: Lottie.asset("assets/order_placed.json")),
          ],
        ));
  }

  void timer(BuildContext context) async {
    Timer(Duration(milliseconds: 6000), () {
      Provider.of<CurrentPage>(context, listen: false).changePageNo(3);
      print("done");
    });
  }
}
