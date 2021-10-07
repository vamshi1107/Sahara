import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/models/product.dart';

import '../pages/search.dart';

class Item extends StatefulWidget {
  Product i;
  Item(this.i) {}

  @override
  State<Item> createState() {
    return ItemState(i);
  }
}

class ItemState extends State<Item> {
  Product i;
  ItemState(this.i) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: itemInner,
          border: Border.all(color: itemBorder, width: 1)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            i.image[0],
            height: 200,
            width: 200,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                i.brand,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              Text(
                i.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
              const SizedBox(height: 45),
              Text(
                i.price,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ],
          )
        ],
      ),
    );
  }
}
