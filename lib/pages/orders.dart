import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/order_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/client.dart';
import '../components/item_shimmer.dart';

class Orders extends StatefulWidget {
  Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return makepage();
  }

  late String _user;
  late var orderItems = [];
  bool loading = false;

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
    var res = await API.getOrders({"user": s.get("user")});
    setState(() {
      orderItems = res;
      loading = false;
    });
  }

  Widget makepage() {
    return Scaffold(
        body: Container(
      color: Colors.blueGrey.shade100,
      child: Column(children: [
        Container(
            width: double.infinity,
            height: 110,
            color: AppColors.primary,
            child: Align(
              alignment: Alignment.bottomLeft,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back)),
                Text(
                  "Orders",
                  style: TextStyle(fontSize: 22),
                ),
              ]),
            )),
        Expanded(
          flex: 2,
          child: body(),
        )
      ]),
    ));
  }

  Widget body() {
    if (loading) {
      return ItemShimmer();
    } else {
      return RefreshIndicator(
          color: Colors.black,
          onRefresh: () async {
            load();
          },
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: orderItems.map((e) => OrderCard(e)).toList(),
            ))
          ]));
    }
  }
}
