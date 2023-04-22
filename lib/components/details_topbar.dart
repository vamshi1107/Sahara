import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

import '../pages/search.dart';

class DetailsTopBar extends StatefulWidget {
  @override
  State<DetailsTopBar> createState() {
    return DetailsTopBarState();
  }
}

class DetailsTopBarState extends State<DetailsTopBar> {
  DetailsTopBarState() {}

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
          height: 100,
          color: AppColors.primary,
          padding: EdgeInsets.fromLTRB(10, 30, 15, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.arrow_back),
                onPressed: () => {back(context)},
              )
            ],
          ),
        )),
      ],
    );
  }
}
