import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() {
    return CartState();
  }
}

class CartState extends State<Cart> {
  CartState() {}

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
