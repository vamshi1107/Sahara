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

  var _api = API();

  List products = [];

  @override
  void initState() {
    super.initState();
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
                onTap: () => {press(context, e)},
              );
            }).toList(),
          ))
        ],
      ))
    ]));
  }

  void press(BuildContext context, Product p) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(p);
    }));
  }

  void onSearch(var value) {
    setState(() {
      _api.getProducts({}).then((value) {
        products = value;
      });
    });
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
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: inner,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.fromLTRB(10, 60, 5, 5),
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  fillColor: inner,
                                ),
                              ))),
                      Flexible(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                onSearch(
                                    searchController.value.text.toString());
                              },
                            ),
                          )),
                    ]))),
      ],
    );
  }
}
