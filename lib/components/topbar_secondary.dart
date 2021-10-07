import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import '../pages/search.dart';

class TopBarSecondary extends StatefulWidget {
  void Function() setSearch;

  TopBarSecondary(void Function() this.setSearch);

  @override
  State<TopBarSecondary> createState() {
    return TopBarSecondarytate(setSearch);
  }
}

class TopBarSecondarytate extends State<TopBarSecondary> {
  void Function() setSearch;

  TopBarSecondarytate(void Function() this.setSearch);

  TopBarSecondaryState() {}

  void openSearch(BuildContext context) {
    setSearch();
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
