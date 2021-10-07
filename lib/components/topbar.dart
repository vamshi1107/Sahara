import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import '../pages/search.dart';

class TopBar extends StatefulWidget {
  @override
  State<TopBar> createState() {
    return TopBarState();
  }
}

class TopBarState extends State<TopBar> {
  TopBarState() {}

  void openSearch(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Search()));
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
                child: Container(
                    decoration: BoxDecoration(
                        color: inner,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: itemBorder, width: 1)),
                    margin: const EdgeInsets.fromLTRB(5, 60, 5, 5),
                    child: InkWell(
                        onTap: () => {openSearch(context)},
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Search",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ))))),
      ],
    );
  }
}
