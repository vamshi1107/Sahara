import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';

import 'search.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  HomeState() {}

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    color: Colors.green,
                  ),
                  Container(
                    height: 300,
                    color: inner,
                  ),
                  Container(
                    height: 300,
                    color: inner,
                  )
                ],
              ),
            )
          ],
        ));
  }
}
