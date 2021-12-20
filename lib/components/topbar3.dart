import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import '../pages/search.dart';

class TopBarMain extends StatefulWidget {
  @override
  State<TopBarMain> createState() {
    return TopBarMainState();
  }
}

class TopBarMainState extends State<TopBarMain> {
  TopBarMainState();

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      color: primary,
      padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Text(
              "Sahara",
              style: TextStyle(fontSize: 27),
            ),
          ),
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.search),
            onPressed: () => {openSearch(context)},
          )
        ],
      ),
    );
  }
}
