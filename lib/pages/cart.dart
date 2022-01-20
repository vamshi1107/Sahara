import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/counter_view.dart';
import 'package:myapp/components/item.dart';
import 'package:myapp/components/item_shimmer.dart';
import 'package:myapp/components/topbar.dart';
import 'package:myapp/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class Cart extends StatefulWidget {
  StatefulWidget TopBar;

  Cart(StatefulWidget this.TopBar);

  @override
  State<Cart> createState() {
    return CartState(TopBar);
  }
}

class CartState extends State<Cart> {
  StatefulWidget TopBar;

  CartState(StatefulWidget this.TopBar) {}

  var cartItems = [];
  late String _user;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueGrey.shade100,
        child: Column(
          children: [
            TopBar,
            Expanded(flex: 2, child: body()),
            Buy(),
          ],
        ));
  }

  Widget body() {
    if (loading) {
      return ItemShimmer();
    } else {
      return CustomScrollView(
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
      );
    }
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
                width: MediaQuery.of(context).size.width * 0.50,
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
                    minNumber: 1,
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

  void inc(String pid, int count) {}

  void dec(String pid, int count) {
    if (count == 1) {
      remove(pid);
    }
  }

  void remove(String pid) async {
    bool res = await API.removeCart({"user": _user, "product": pid});
    if (res) {
      load();
    }
  }

  Widget Buy() {
    return Container(
        width: double.infinity,
        height: 50,
        margin: EdgeInsets.all(10),
        child: MaterialButton(
          onPressed: () {},
          child: Text(
            "Proceed to buy",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.black,
        ));
  }
}
