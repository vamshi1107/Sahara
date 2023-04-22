import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/helpers/helper.dart';
import 'package:myapp/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      margin: EdgeInsets.fromLTRB(7, 7, 7, 0),
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Colors.white,
      ),
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
                width: MediaQuery.of(context).size.width * 0.40,
                child: AutoSizeText(
                  i.name,
                  maxLines: 3,
                  minFontSize: 12,
                  style: const TextStyle(
                    fontSize: 16,
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
                  onPressed: () {
                    addCart();
                  },
                  child: Text(
                    "Add to cart",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.lightBlueAccent))),
            ],
          )
        ],
      ),
    );
  }

  void addCart() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var res = await Helper.addToCart(i.id, s.get("user").toString());
    if (res) {
      showSnackbar("Added to cart", AppColors.snackOk);
    }
  }

  void showSnackbar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 500),
      content: Container(
        child: Text(msg),
      ),
      backgroundColor: color,
    ));
  }
}
