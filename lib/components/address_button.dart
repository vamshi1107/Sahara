import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/models/Address.dart';
import 'package:myapp/states/SelectedAddress.dart';
import 'package:provider/provider.dart';

class AddressButton extends StatefulWidget {
  var address;

  AddressButton(this.address);

  @override
  AddressButtonState createState() {
    return AddressButtonState(this.address);
  }
}

class AddressButtonState extends State<AddressButton> {
  var address;

  AddressButtonState(this.address);

  @override
  void initState() {
    super.initState();
  }

  void toggleSelected() {
    var selected =
        Provider.of<SelectedAddress>(context, listen: false).addressId;
    if (selected == address["addressId"]) {
      Provider.of<SelectedAddress>(context, listen: false)
          .changeSelectedAddress("");
    } else {
      Provider.of<SelectedAddress>(context, listen: false)
          .changeSelectedAddress(address["addressId"]);
    }
  }

  bool isAddressSelected() {
    return Provider.of<SelectedAddress>(context, listen: true).addressId ==
        address["addressId"];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        toggleSelected();
      },
      child: Container(
          width: double.infinity,
          height: 180,
          margin: EdgeInsets.all(6),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: isAddressSelected() ? 3 : 2,
                  color: isAddressSelected() ? Colors.blue : Colors.black26)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: getText(address["fullname"], false, true),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10)),
              getText(
                  address["houseno"] + " , " + address["area"], true, false),
              getText(address["city"] + "," + address["pincode"], true, false),
              getText(address["state"] + "," + address["country"], true, false),
              getText(address["mobile"], true, false),
            ],
          )),
    );
  }

  Widget getText(String text, bool isSmall, bool isBold) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
        child: Text(text,
            style: TextStyle(
                fontSize: isSmall ? 16 : 18,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal)));
  }
}
