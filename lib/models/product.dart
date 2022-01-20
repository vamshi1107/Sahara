import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.name,
    required this.brand,
    required this.quantity,
    required this.id,
    required this.price,
    required this.mrp,
    required this.images,
    required this.specifications,
  });

  String name;
  String brand;
  String quantity;
  String id;
  String price;
  String mrp;
  List<String> images;
  List<String> specifications;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        brand: json["brand"],
        quantity: json["quantity"],
        id: json["id"],
        price: json["price"],
        mrp: json["mrp"],
        images: List<String>.from(json["images"].map((x) => x)),
        specifications: List<String>.from(json["specifications"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "quantity": quantity,
        "id": id,
        "price": price,
        "mrp": mrp,
        "images": List<dynamic>.from(images.map((x) => x)),
        "specifications": List<dynamic>.from(specifications.map((x) => x)),
      };
}
