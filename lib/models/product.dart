// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.mrp,
    required this.images,
    required this.specifications,
  });

  String id;
  String name;
  String brand;
  String price;
  String mrp;
  List<String> images;
  List<String> specifications;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        mrp: json["mrp"],
        images: List<String>.from(json["images"].map((x) => x)),
        specifications: List<String>.from(json["specifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "brand": brand,
        "price": price,
        "mrp": mrp,
        "images": List<dynamic>.from(images.map((x) => x)),
        "specifications": List<dynamic>.from(specifications.map((x) => x)),
      };
}
