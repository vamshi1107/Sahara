import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/details_topbar.dart';

import 'package:myapp/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import 'account.dart';

class Details extends StatefulWidget {
  Product p;

  Details(Product this.p);

  @override
  _DetailsState createState() => _DetailsState(p);
}

class _DetailsState extends State<Details> {
  Product p;

  _DetailsState(Product this.p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        DetailsTopBar(),
        Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              p.brand,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              p.name,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      CarouselSlider.builder(
                        itemCount: p.images.length,
                        options: CarouselOptions(
                            enlargeCenterPage: true,
                            height: 350,
                            reverse: false,
                            enableInfiniteScroll: false,
                            autoPlay: false,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 300)),
                        itemBuilder: (context, i, r) {
                          return Container(
                            child: Image.network(
                              p.images[i],
                            ),
                          );
                        },
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Rs " + p.price,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Buy now"),
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Add to cart",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                              (states) => Colors.white))),
                            ],
                          )),
                      Container(
                        child: Column(
                          children: [],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ],
    ));
  }
}
