import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/assests/colors.dart';
import 'package:myapp/components/address_button.dart';
import 'package:myapp/components/address_input.dart';
import 'package:myapp/components/main_button.dart';
import 'package:myapp/components/topbar_main.dart';
import 'package:myapp/models/address.dart';
import 'package:myapp/states/CurrentPage.dart';
import 'package:myapp/states/SelectedAddress.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyPage extends StatefulWidget {
  @override
  BuyState createState() {
    return BuyState();
  }
}

class BuyState extends State<BuyPage> {
  int step = 0;
  List addressList = [];

  void chnageStep(int s) {
    setState(() {
      step = s;
    });
  }

  @override
  void initState() {
    loadAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        TopBarMain(),
        Expanded(
            child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StepButton("Select address", 0),
                      StepButton("Proceed to Pay", 1)
                    ],
                  )),
              Expanded(
                child: [Address(), Payment()][step],
              ),
              BottomCard()
            ],
          ),
        ))
      ],
    ));
  }

  Future<void> loadAddresses() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var name = sp.getString("user")!;
    var res = await API.getAddress({"user": name});
    setState(() {
      addressList = res;
    });
  }

  void placeOrder() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var name = sp.getString("user")!;
    var address =
        Provider.of<SelectedAddress>(context, listen: false).addressId;
    var res = await API.placeOrder({"user": name, "address": address});
    if (res) {
      print(res);
      Provider.of<CurrentPage>(context, listen: false).changePageNo(6);
    }
  }

  void onSelectedChange(bool value) {
    print(value);
  }

  Widget AddressSheet() {
    return Container(child: AddressInput());
  }

  Widget Address() {
    return Container(
      color: AppColors.innerDark,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: MaterialButton(
                  onPressed: () => {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return AddressSheet();
                            },
                            constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height * 0.85,
                            ))
                      },
                  color: Colors.white,
                  height: 60,
                  minWidth: MediaQuery.of(context).size.width * 0.45,
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(width: 2)),
                  child: Text(
                    "Add Address",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(List.generate(
                  addressList.length,
                  (index) => AddressButton(addressList.elementAt(index))))),
        ],
      ),
    );
  }

  Widget Payment() {
    return Container(
      width: double.infinity,
      color: AppColors.innerDark,
      child: Column(
        children: [
          paymentOption("Detbit/Credit Card"),
          paymentOption("UPI"),
          paymentOption("EMI"),
        ],
      ),
    );
  }

  Widget paymentOption(String text) {
    return Container(
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      width: double.infinity,
      height: 100,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black26),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget StepButton(String name, int stepno) {
    return TextButton(
        onPressed: () {
          if (stepno == 1 && isAddressSelected()) {
            chnageStep(stepno);
          }
          if (stepno == 0) {
            chnageStep(stepno);
          }
        },
        child: Text(
          name,
          style: TextStyle(
              color: stepno == step ? Colors.black : Colors.black38,
              fontSize: stepno == step ? 16 : 14),
        ));
  }

  bool isAddressSelected() {
    return Provider.of<SelectedAddress>(context, listen: true).addressId != "";
  }

  Widget BottomCard() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      color: AppColors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: TextButton(
                  onPressed: () {
                    if (step == 0) {
                      Provider.of<CurrentPage>(context, listen: false)
                          .changePageNo(3);
                    } else {
                      chnageStep(0);
                    }
                  },
                  child: Text(
                    step == 0 ? "Back to Cart" : "Back",
                    style: TextStyle(fontSize: 16),
                  ))),
          Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: step == 0
                  ? MainButton(context, "Next", () {
                      chnageStep(1);
                    }, !isAddressSelected())
                  : MainButton(context, step == 0 ? "Next" : "Place Order", () {
                      placeOrder();
                    }, !isAddressSelected()))
        ],
      ),
    );
  }
}
