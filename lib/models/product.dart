import 'dart:ffi';

class Product {
  int id = 0;
  String name = "";
  String brand = "";
  List<String> image = [];
  String price = "";

  Product(this.id, this.name, this.brand, this.image, this.price);
}
