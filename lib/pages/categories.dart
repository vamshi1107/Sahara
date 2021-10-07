import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() {
    // TODO: implement createState
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  CategoryState() {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Container(
          width: double.infinity,
          height: 200,
          color: inner,
        ));
  }
}
