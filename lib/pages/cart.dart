import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/topbar.dart';

class Cart extends StatefulWidget {
  StatefulWidget TopBar;

  Cart(StatefulWidget this.TopBar);

  @override
  State<Cart> createState() {
    return CartState(TopBar);
  }
}

class CartState extends State<Cart> {
  StatefulWidget TopBar;

  CartState(StatefulWidget this.TopBar) {}

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
