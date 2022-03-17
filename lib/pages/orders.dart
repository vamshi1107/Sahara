import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            width: double.infinity,
            height: 110,
            color: primary,
            child: Align(
              alignment: Alignment.bottomLeft,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text(
                  "Orders",
                  style: TextStyle(fontSize: 22),
                ),
              ]),
            )),
        Expanded(
          flex: 2,
          child: CustomScrollView(
              slivers: [SliverToBoxAdapter(child: Container())]),
        )
      ]),
    );
  }
}
