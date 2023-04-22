import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:myapp/models/address.dart';
import 'package:myapp/models/product.dart';

class API {
  // static var url = "https://myserver1107.herokuapp.com/sahara/";
  static var url = "http://localhost:9000/sahara/";

  static var headers = {
    "accept": "application/json",
    "content-type": "application/json"
  };

  static Future<bool> userSignup(var body) async {
    var response = await post(Uri.parse(url + "signup"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> userLogin(var body) async {
    var response = await post(Uri.parse(url + "login"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result;
  }

  static Future<dynamic> getProducts(var body) async {
    var response = await post(Uri.parse(url + "getProducts"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result.map((json) => Product.fromJson(json)).toList();
  }

  static Future<bool> addLiked(var body) async {
    var response = await post(Uri.parse(url + "addliked"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> getLiked(var body) async {
    var response = await post(Uri.parse(url + "getliked"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result["result"].map((json) => Product.fromJson(json)).toList();
  }

  static Future<bool> addCart(var body) async {
    var response = await post(Uri.parse(url + "addcart"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> getCart(var body) async {
    var response = await post(Uri.parse(url + "getcart"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result["result"].map((json) => Product.fromJson(json)).toList();
  }

  static Future<dynamic> getOrders(var body) async {
    var response = await post(Uri.parse(url + "getorders"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result["result"];
  }

  static Future<bool> removeCart(var body) async {
    var response = await post(Uri.parse(url + "removecart"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> removeLiked(var body) async {
    var response = await post(Uri.parse(url + "removeliked"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isLiked(var body) async {
    var response = await post(Uri.parse(url + "isliked"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["result"]) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> changeQuantity(var body) async {
    var response = await post(Uri.parse(url + "changequantity"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["result"]) {
      return true;
    } else {
      return false;
    }
  }

  static Future<dynamic> getAddress(var body) async {
    var response = await post(Uri.parse(url + "getaddresses"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result["result"] ? result["data"].toList() : [];
  }

  static Future<bool> addAddress(var body) async {
    var response = await post(Uri.parse(url + "addaddress"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> placeOrder(var body) async {
    var response = await post(Uri.parse(url + "placeorder"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["result"] && result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }
}
