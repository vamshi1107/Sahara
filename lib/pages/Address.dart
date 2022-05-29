import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';

class Address extends StatefulWidget {
  Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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
                  "Address",
                  style: TextStyle(fontSize: 22),
                ),
              ]),
            )),
        Expanded(
          flex: 2,
          child: CustomScrollView(slivers: [SliverToBoxAdapter(child: Body())]),
        )
      ]),
    );
  }

  Widget Body() {
    return Container(
        child: Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [IconButton(onPressed: () {}, icon: Icon(Icons.add))])
    ]));
  }
}
