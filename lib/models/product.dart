import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String name;
  String brand;
  List<String> images;
  String price;
  String mrp;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.images,
    required this.price,
    required this.mrp,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        images: List<String>.from(json["images"].map((x) => x)),
        price: json["price"],
        mrp: json["mrp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "images": List<dynamic>.from(images.map((x) => x)),
        "price": price,
        "mrp": mrp,
      };
}
