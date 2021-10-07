import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/search_topbar.dart';
import 'package:myapp/models/product.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/pages/details.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() {
    // TODO: implement createState
    return SearchState();
  }
}

class SearchState extends State<Search> {
  SearchState() {}

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  var p = Product(
      01,
      "Iphone 12 pro",
      "Apple",
      [
        "https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/katariy/Apple/Family_stripe/AMZ_FamilyStripe_iPhone_13ProMax._CB640925209_.png",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS77kge8fheZqbnerRzPBqvF-lAy9Mg2ivYRQ&usqp=CAU",
        "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iPhone-13-Pro_New-Camera-System_09142021_Full-Bleed-Image.jpg.large_2x.jpg"
      ],
      "12500");

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SearchTopBar(),
      Expanded(
          child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                InkWell(
                  child: Item(p),
                  onTap: () => {show(context, p)},
                ),
                InkWell(
                  child: Item(p),
                  onTap: () => {show(context, p)},
                ),
                InkWell(
                  child: Item(p),
                  onTap: () => {show(context, p)},
                ),
                InkWell(
                  child: Item(p),
                  onTap: () => {show(context, p)},
                ),
                InkWell(
                  child: Item(p),
                  onTap: () => {show(context, p)},
                ),
              ],
            ),
          ),
        ],
      ))
    ]);
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
                  itemCount: p.image.length,
                  options: CarouselOptions(
                      enlargeCenterPage: true,
                      reverse: false,
                      enableInfiniteScroll: false,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 300)),
                  itemBuilder: (context, i, r) {
                    return Container(
                      child: Image.network(
                        p.image[i],
                        height: 300,
                        width: 300,
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
                    RaisedButton(
                      child: Text("Details"),
                      onPressed: () => {this.press(context)},
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      child: Text("Add to Cart"),
                      onPressed: () => {this.press(context)},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void press(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details();
    }));
  }
}
