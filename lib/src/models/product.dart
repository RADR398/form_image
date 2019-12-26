// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

class ProductModel {
  String id;
  String title;
  double value;
  bool available;
  String photoUrl;

  ProductModel({
    this.id,
    this.title,
    this.value = 0.0,
    this.available = false,
    this.photoUrl,
  });

  factory ProductModel.fromJson(String str) => ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    value: json["value"].toDouble(),
    available: json["available"],
    photoUrl: json["photoUrl"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "value": value,
    "available": available,
    "photoUrl": photoUrl,
  };
}