import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/address_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/client.dart';
import '../components/item_shimmer.dart';

class Address extends StatefulWidget {
  Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  late String _user;
  late var addressItems = [];
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
    var res = await API.getAddress({"user": s.get("user")});
    setState(() {
      addressItems = res;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body: Column(children: [
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
                  "Address",
                  style: TextStyle(fontSize: 22),
                ),
              ]),
            )),
        Button(),
        Expanded(
          flex: 2,
          child: AddressContent(),
        ),
      ]),
    );
  }

  Widget Button() {
    return Container(
        child: Column(children: [
      Container(
        height: 60,
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: MaterialButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return AddressSheet();
                },
                constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height * 0.85,
                ));
          },
          child: Text(
            "Add Address",
            style: TextStyle(color: Colors.white),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: Colors.black,
        ),
      ),
    ]));
  }

  Widget AddressContent() {
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
              child: Container(
                height: 10,
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
                    addressItems.map((e) => AddressItem(e)).toList()))
          ]));
    }
  }

  Widget AddressItem(Map e) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black54)),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 10,
              ),
              Text(
                e["fullname"],
                style: TextStyle(fontSize: 17),
              ),
              Container(
                height: 5,
              ),
              AutoSizeText(
                ["houseno", "area", "city", "state", "country"]
                    .map((i) => e[i])
                    .join(","),
                minFontSize: 16,
                maxFontSize: 17,
              ),
              TextInfo("Pincode", e["pincode"]),
              TextInfo("Mobile", e["mobile"]),
              TextInfo("Landmark", e["landmark"])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.black),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.black),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget TextInfo(String heading, String value) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(children: [
          Text(
            heading + " : ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ]));
  }

  Widget AddressSheet() {
    return Container(child: AddressInput());
  }
}
