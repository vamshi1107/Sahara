import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/details_topbar.dart';
import 'package:myapp/helpers/helper.dart';

import 'package:myapp/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account.dart';

class Details extends StatefulWidget {
  Product p;

  Details(Product this.p);

  @override
  _DetailsState createState() => _DetailsState(p);
}

class _DetailsState extends State<Details> {
  bool _liked = false;
  Product p;

  _DetailsState(Product this.p);

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var _user = s.getString("user").toString();
    var isLiked = await API.isLiked({"user": _user, "product": p.id});
    setState(() {
      _liked = isLiked;
    });
  }

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedOpacity(
                          opacity: 1.0,
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    flex: 3,
                                    child: Text(
                                      p.name,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                          )),
                      AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          height: 50,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  likeChanged(p);
                                },
                                icon: _liked
                                    ? Icon(Icons.favorite)
                                    : Icon(Icons.favorite_border),
                              ),
                            ],
                          )),
                      Container(
                        height: 350,
                        width: 350,
                        child: Hero(
                            tag: p.id,
                            child: Image.network(
                              p.images[0],
                              fit: BoxFit.contain,
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 20, 20, 0),
                        child: Text(
                          "Rs " + p.price,
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 7, 20, 20),
                        child: Text(
                          "M.R.P " + p.mrp,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.redAccent,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Container(
                          height: 120,
                          margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Buy now"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100.0, 50.0),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  addCart();
                                },
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(width: 1),
                                  minimumSize: Size(100.0, 50.0),
                                  onSurface: Colors.yellow,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(15, 20, 10, 10),
                          child: Text(
                            "",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )),
                      Container(
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              itemCount: p.images.length,
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: 350,
                                  pauseAutoPlayInFiniteScroll: true,
                                  reverse: false,
                                  enableInfiniteScroll: true,
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 300)),
                              itemBuilder: (context, i, r) {
                                return Container(
                                    height: 250,
                                    width: 250,
                                    child: Image.network(
                                      p.images[i],
                                      fit: BoxFit.contain,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(30, 20, 0, 10),
                        child: Text(
                          "Highlights",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      getDetails(p)
                    ],
                  ),
                )
              ],
            )),
      ],
    ));
  }

  void addCart() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    var res = await Helper.addToCart(p.id, s.get("user").toString());
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

  Widget getDetails(var p) {
    return Container(
      margin: EdgeInsets.fromLTRB(25, 10, 25, 120),
      child: Column(
        children: getRows(p.specifications),
      ),
    );
  }

  List<Widget> getRows(var e) {
    var textstyle = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
    return p.specifications.map((e) {
      return Container(
          margin: EdgeInsets.all(10),
          child: Text(
            e,
            style: textstyle,
          ));
    }).toList();
  }

  void likeChanged(Product p) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    setState(() {
      _liked = !_liked;
    });
    if (_liked) {
      await API.addLiked({"product": p.id, "user": s.get("user")});
    } else {
      await API.removeLiked({"product": p.id, "user": s.get("user")});
    }
  }
}
