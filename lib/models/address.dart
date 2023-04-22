// To parse this JSON data, do
//
//     final address = addressFromJson(jsonString);

import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    required this.addressId,
    required this.user,
    required this.fullname,
    required this.mobile,
    required this.pincode,
    required this.houseno,
    required this.area,
    required this.landmark,
    required this.city,
    required this.state,
    required this.country,
  });

  String addressId;
  String user;
  String fullname;
  String mobile;
  String pincode;
  String houseno;
  String area;
  String landmark;
  String city;
  String state;
  String country;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json["addressId"],
        user: json["user"],
        fullname: json["fullname"],
        mobile: json["mobile"],
        pincode: json["pincode"],
        houseno: json["houseno"],
        area: json["area"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "addressId": addressId,
        "user": user,
        "fullname": fullname,
        "mobile": mobile,
        "pincode": pincode,
        "houseno": houseno,
        "area": area,
        "landmark": landmark,
        "city": city,
        "state": state,
        "country": country,
      };
}
