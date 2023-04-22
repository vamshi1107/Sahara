import 'package:flutter/material.dart';
import 'package:myapp/api/client.dart';
import 'package:myapp/components/main_button.dart';
import 'package:myapp/models/address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressInput extends StatefulWidget {
  @override
  AddressInputState createState() {
    return new AddressInputState();
  }
}

class AddressInputState extends State<AddressInput> {
  Map<String, String> address = {
    "fullname": "",
    "mobile": "",
    "pincode": "",
    "houseno": "",
    "area": "",
    "landmark": "",
    "city": "",
    "state": "",
    "country": ""
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: List.of(address.keys).length + 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
                alignment: AlignmentDirectional.center,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "New Address",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close))
                  ],
                ));
          } else if (index == List.of(address.keys).length + 1) {
            return Container(
              margin: EdgeInsets.all(10),
              child: MainButton(context, "Save", () {
                addAddress();
              }, false),
            );
          } else {
            return getFeild(List.of(address.keys).elementAt(index - 1));
          }
        },
      ),
    );
  }

  void addAddress() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var body = address;
    body["user"] = sp.getString("user")!;
    var res = await API.addAddress(body);
    if (res) {
      Navigator.pop(context);
    }
  }

  void changeText(String field, String text) {
    setState(() {
      address[field] = text;
    });
  }

  Widget getFeild(String name) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            name[0].toUpperCase() + name.substring(1),
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            initialValue: address[name],
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(border: OutlineInputBorder()),
            onChanged: (text) {
              changeText(name, text);
            },
          ),
        ]));
  }
}
