import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';

class Category extends StatefulWidget {
  StatefulWidget TopBar;

  Category(StatefulWidget this.TopBar);
  @override
  State<Category> createState() {
    // TODO: implement createState
    return CategoryState(TopBar);
  }
}

class CategoryState extends State<Category> {
  StatefulWidget TopBar;

  CategoryState(StatefulWidget this.TopBar) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar,
        Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              height: 200,
              color: inner,
            ))
      ],
    );
  }
}
