import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/search_topbar.dart';
import 'package:myapp/models/product.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/pages/details.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  SearchState() {}

  TextEditingController searchController = new TextEditingController();

  List products = [];

  @override
  void initState() {
    super.initState();
    var api = API();
    setState(() {
      api.getProducts({}).then((value) {
        products = value;
      });
    });
  }

  void back(BuildContext context) {
    Navigator.pop(context);
  }

  var searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      topBar(),
      Expanded(
          child: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
            searchResults.map((e) {
              return GestureDetector(
                child: Item(e),
                onTap: () => {show(context, e)},
              );
            }).toList(),
          ))
        ],
      ))
    ]));
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
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(p);
    }));
  }

  void onSearch(var value) {
    if (value.replaceAll(" ", "").length > 0) {
      var searched = products
          .where((product) => product.name
              .replaceAll(" ", "")
              .toLowerCase()
              .contains(value.replaceAll(" ", "").toLowerCase()))
          .toList();
      setState(() {
        searchResults = searched;
      });
    } else {
      setState(() {
        searchResults = [];
      });
    }
  }

  Widget topBar() {
    return Stack(
      children: [
        Positioned(
            child: Container(
                width: double.infinity,
                height: 110,
                color: primary,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                back(context);
                              },
                            ),
                          )),
                      Flexible(
                          flex: 4,
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                  color: inner,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.fromLTRB(0, 60, 5, 5),
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {
                                  onSearch(value);
                                },
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  border: OutlineInputBorder(),
                                  fillColor: inner,
                                ),
                              )))
                    ]))),
      ],
    );
  }
}
