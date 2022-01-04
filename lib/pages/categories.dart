import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_secondary.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/models/product.dart';

import 'details.dart';

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

  var likedResults = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar,
        Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                SliverList(
                    delegate: SliverChildListDelegate(
                  likedResults.map((e) {
                    return GestureDetector(
                      child: Item(e),
                      onTap: () => {press(context, e)},
                    );
                  }).toList(),
                ))
              ],
            ))
      ],
    );
  }

  void show(BuildContext context, Product p) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Text(
                  p.name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                CarouselSlider.builder(
                  itemCount: p.images.length,
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      reverse: false,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 300)),
                  itemBuilder: (context, i, r) {
                    return Container(
                      child: Image.network(
                        p.images[i],
                      ),
                    );
                  },
                ),
                Text(
                  "Rs " + p.price,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: Text("Details"),
                      onPressed: () => {this.press(context, p)},
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text("Add to Cart"),
                      onPressed: () => {this.press(context, p)},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void press(BuildContext context, Product p) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(p);
    }));
  }
}
