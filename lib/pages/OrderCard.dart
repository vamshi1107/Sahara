import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  OrderCard({Key? key}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool open = false;

  void change() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black54, width: 0.4),
      ),
      margin: EdgeInsets.all(6),
      duration: Duration(milliseconds: 300),
      child: AnimatedCrossFade(
          firstChild: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              height: 200,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    height: 150,
                  ),
                  MaterialButton(
                      onPressed: () => {change()}, child: Text("Details"))
                ],
              )),
          secondChild: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 500,
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 450,
                ),
                MaterialButton(onPressed: () => {change()}, child: Text("Hide"))
              ],
            ),
          ),
          crossFadeState:
              open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300)),
    );
  }
}
