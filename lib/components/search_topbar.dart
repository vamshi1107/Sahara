import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import '../pages/search.dart';

class SearchTopBar extends StatefulWidget {
  @override
  State<SearchTopBar> createState() {
    return SearchTopBarState();
  }
}

class SearchTopBarState extends State<SearchTopBar> {
  SearchTopBarState() {}

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Container(
                width: double.infinity,
                height: 110,
                color: primary,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: inner,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.fromLTRB(0, 60, 5, 5),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: OutlineInputBorder(),
                                  fillColor: inner,
                                ),
                              )))
                    ]))),
      ],
    );
  }
}
