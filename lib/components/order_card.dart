import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/progress_bar.dart';

class OrderCard extends StatefulWidget {
  Map order;
  OrderCard(this.order);

  @override
  State<OrderCard> createState() => _OrderCardState(this.order);
}

class _OrderCardState extends State<OrderCard> {
  bool open = false;

  Map order;

  _OrderCardState(this.order);

  void change() {
    setState(() {
      open = !open;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.black54, width: 0.4),
      ),
      margin: EdgeInsets.all(6),
      duration: Duration(milliseconds: 300),
      child: AnimatedCrossFade(
          firstChild: CardOne(),
          secondChild: CardTwo(),
          crossFadeState:
              open ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: Duration(milliseconds: 300)),
    );
  }

  Widget CardOne() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            Common(),
            MaterialButton(onPressed: () => {change()}, child: Text("Details"))
          ],
        ));
  }

  Widget Common() {
    return Container(
      height: 150,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.all(10),
            child: Image.network(
              order["images"][0],
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: AutoSizeText(
                  order["name"],
                  maxLines: 3,
                  minFontSize: 12,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                getStatus(order["status"]),
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  String getStatus(String status) {
    if (status == "pending") {
      return "Order placed";
    }
    return "";
  }

  int getProgress(String status) {
    if (status == "pending") {
      return 1;
    }
    if (status == "ondelivery") {
      return 2;
    }
    return 3;
  }

  Widget CardTwo() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 550,
      width: double.infinity,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Common(),
          ProgressBar(getProgress(order["status"])),
          Container(
            color: Color.fromARGB(255, 228, 227, 227),
            height: 250,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  order["message"],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 30,
                ),
                Text(
                  "Address",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  order["address"]["fullname"],
                  style: TextStyle(fontSize: 17),
                ),
                AutoSizeText(
                  ["houseno", "area", "city", "state", "country"]
                      .map((e) => order["address"][e])
                      .join(","),
                  minFontSize: 16,
                  maxFontSize: 17,
                ),
                TextInfo("Pincode", order["address"]["pincode"]),
                TextInfo("Mobile", order["address"]["mobile"]),
                TextInfo("Landmark", order["address"]["landmark"])
              ],
            ),
          ),
          MaterialButton(onPressed: () => {change()}, child: Text("Hide"))
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
}
