import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:myapp/models/product.dart';

class API {
  var url = "http://localhost:9000/sahara/";
  var headers = {
    "accept": "application/json",
    "content-type": "application/json"
  };

  Future<bool> userSignup(var body) async {
    var response = await post(Uri.parse(url + "signup"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    if (result["count"] > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> userLogin(var body) async {
    var response = await post(Uri.parse(url + "login"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result;
  }

  Future<dynamic> getProducts(var body) async {
    var response = await post(Uri.parse(url + "getProducts"),
        body: jsonEncode(body), headers: headers);
    var result = jsonDecode(response.body.toString());
    return result["result"].map((json) => Product.fromJson(json)).toList();
  }
}
