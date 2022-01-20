import 'package:myapp/api/client.dart';

class Helper {
  static Future<bool> addToCart(String pid, String user) async {
    var resp = await API.addCart({"product": pid, "user": user, "quantity": 1});
    return resp;
  }
}
