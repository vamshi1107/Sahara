import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/counter_view.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/item_shimmer.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/components/topbar_main.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/buy.dart';
import 'package:myapp/states/CurrentPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Cart extends StatefulWidget {
  @override
  State<Cart> createState() {
    return CartState();
  }
}

class CartState extends State<Cart> {
  CartState() {}

  var cartItems = [];
  late String _user;
  bool loading = false;
  double total = 0;
  var pricelist = {};

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    _user = s.get("user").toString();
    setState(() {
      loading = true;
    });
    var res = await API.getCart({"user": s.get("user")});
    setState(() {
      cartItems = res;
      loading = false;
    });
    buildList();
    calculate();
  }

  void buildList() {
    pricelist = {};
    cartItems.forEach((e) {
      pricelist[e.id] = {"quantity": e.quantity, "price": e.price};
    });
    calculate();
  }

  void calculate() {
    double t = 0;
    var s = "";
    pricelist.forEach((key, p) {
      s = p["price"].toString();
      s = s.replaceAll(",", "").replaceAll(" ", "");
      t += int.parse(p["quantity"]) * double.parse(s);
    });
    setState(() {
      total = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade100,
        child: Column(
          children: [
            TopBarMain(),
            Expanded(flex: 2, child: body()),
            Buy(),
          ],
        ));
  }

  Widget body() {
    if (loading) {
      return ItemShimmer();
    } else {
      return RefreshIndicator(
          color: Colors.black,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  height: 10,
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                cartItems.map((e) {
                  return GestureDetector(
                    child: CartItem(e),
                    onTap: () => {},
                  );
                }).toList(),
              ))
            ],
          ),
          onRefresh: load);
    }
  }

  void ImageOpen(List<String> urls) {
    ImageClose();
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 500,
              padding: EdgeInsets.all(5),
              child: CarouselSlider.builder(
                itemCount: urls.length,
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 350,
                    pauseAutoPlayInFiniteScroll: true,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 300)),
                itemBuilder: (context, i, r) {
                  return Container(
                      height: 250,
                      width: 250,
                      child: Image.network(
                        urls[i],
                        fit: BoxFit.contain,
                      ));
                },
              ));
        });
  }

  void ImageClose() {
    ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
  }

  Widget CartItem(Product i) {
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
                child: GestureDetector(
                    onTap: () => ImageOpen(i.images),
                    child: Image.network(
                      i.images[0],
                      fit: BoxFit.contain,
                    ))),
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
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CounterView(
                    product: i.id,
                    initNumber: int.parse(i.quantity),
                    counterCallback: counter,
                    increaseCallback: inc,
                    decreaseCallback: dec,
                    minNumber: 0,
                    maxNumber: 5,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  void counter(String pid, int count) {}

  void change(String pid, int count) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    _user = s.get("user").toString();
    var res = await API.changeQuantity(
        {"user": _user, "product": pid, "value": count.toString()});
    pricelist[pid]["quantity"] = count.toString();
    calculate();
  }

  void inc(String pid, int count) async {
    change(pid, count);
  }

  void dec(String pid, int count) {
    if (count == 0) {
      remove(pid);
    } else {
      change(pid, count);
    }
  }

  void remove(String pid) async {
    bool res = await API.removeCart({"user": _user, "product": pid});
    if (res) {
      load();
    }
  }

  Widget Buy() {
    var dwidth = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: 100,
      color: AppColors.primary,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: dwidth * 0.4,
            child: Center(
              child: Text(
                cartItems.length > 0 ? "Rs:" + total.toString() : "",
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          MaterialButton(
              onPressed: () {
                if (cartItems.length > 0) {
                  Provider.of<CurrentPage>(context, listen: false)
                      .changePageNo(5);
                }
              },
              color: cartItems.length > 0 ? Colors.black : Colors.black26,
              height: 60,
              minWidth: dwidth * 0.45,
              elevation: cartItems.length > 0 ? 10 : 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0)),
              child: Text(
                "Proceed to Buy",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
