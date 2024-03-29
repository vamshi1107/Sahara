import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/item_shimmer.dart';
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

  bool loading = false;

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
        body: Container(
            color: Colors.blueGrey.shade100,
            child: Column(children: [topBar(), Expanded(child: body())])));
  }

  Widget body() {
    if (loading) {
      return ItemShimmer();
    } else {
      return CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate(
            searchResults.map((e) {
              print(e);
              return GestureDetector(
                child: Item(e),
                onTap: () => {press(context, e)},
              );
            }).toList(),
          ))
        ],
      );
    }
  }

  void press(BuildContext context, Product p) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(p);
    }));
  }

  void onSearch(var value) {
    setState(() {
      loading = true;
    });
    API.getProducts({"value": value}).then((value) {
      setState(() {
        searchResults = value;
        loading = false;
        print(searchResults.length);
      });
    });
  }

  Widget topBar() {
    return Stack(
      children: [
        Positioned(
            child: Container(
                width: double.infinity,
                height: 110,
                color: AppColors.primary,
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
                                  color: AppColors.inner,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.fromLTRB(10, 60, 5, 5),
                              child: TextField(
                                controller: searchController,
                                onChanged: (value) {},
                                textInputAction: TextInputAction.go,
                                onSubmitted: (value) {
                                  onSearch(
                                      searchController.value.text.toString());
                                },
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  fillColor: AppColors.inner,
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
