import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import 'search.dart';

class Home extends StatefulWidget {
  StatefulWidget TopBarSecondary;

  Home(StatefulWidget this.TopBarSecondary);

  @override
  State<Home> createState() {
    return HomeState(TopBarSecondary);
  }
}

class HomeState extends State<Home> {
  StatefulWidget TopBarSecondary;

  HomeState(StatefulWidget this.TopBarSecondary) {}

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBarSecondary,
        Expanded(
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
            ))
      ],
    );
  }
}
