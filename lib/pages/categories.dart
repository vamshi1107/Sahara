import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/item_shimmer.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/helpers/helper.dart';
import 'package:myapp/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'details.dart';

class Category extends StatefulWidget {
  Category();
  @override
  State<Category> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  CategoryState() {}

  late String _user;

  var likedResults = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    _user = s.getString("user").toString();
    setState(() {
      loading = true;
    });
    var res = await API.getLiked({"user": s.get("user")});

    setState(() {
      likedResults = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.innerDark,
        child: Column(
          children: [TopBarMain(), Expanded(flex: 2, child: body())],
        ));
  }

  void reload() {
    load();
  }

  Widget body() {
    if (loading) {
      return ItemShimmer();
    } else {
      return RefreshIndicator(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 10,
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                likedResults.map((e) {
                  return GestureDetector(
                    child: likedItem(e),
                    onTap: () => {press(context, e)},
                  );
                }).toList(),
              ))
            ],
          ),
          onRefresh: load);
    }
  }

  Widget likedItem(Product i) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
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
                  maxLines: 2,
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
              OutlinedButton(
                onPressed: () {
                  remove(i);
                },
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void remove(Product p) async {
    bool res = await API.removeLiked({"user": _user, "product": p.id});
    if (res) {
      load();
    }
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal),
                ),
                SizedBox(
                  height: 30,
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
                      onPressed: () => {this.details(context, p)},
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text("Add to Cart"),
                      onPressed: () => {this.addCart(p.id)},
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  void addCart(String id) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var res = await Helper.addToCart(id, s.get("user").toString());
    if (res) {
      showSnackbar("Added to cart", Colors.greenAccent);
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

  void details(BuildContext context, Product p) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Details(p);
    }));
  }

  void press(BuildContext context, Product p) {
    show(context, p);
  }
}
