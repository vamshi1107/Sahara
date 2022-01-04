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
          border: Border.all(color: itemBorder, width: 1.3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.all(10),
            child: Hero(
                tag: i.id,
                child: Image.network(
                  i.images[0],
                  fit: BoxFit.contain,
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: Text(
                  i.name,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Text(
                "Rs " + i.price,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.white))),
            ],
          )
        ],
      ),
    );
  }
}
