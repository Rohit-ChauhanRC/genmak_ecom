import 'package:flutter/services.dart';
import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  final int? id;
  final String? name;
  final String? weight;
  final String? price;
  late String? quantity;
  final String? description;
  final Uint8List? picture;
  late int? count;
  int? active;
  String? gst;
  String? discount;
  String? hsnCode;
  String? unit;
  String? invoiceId;

  ProductModel({
    this.id,
    this.name,
    this.weight,
    this.price,
    this.quantity,
    this.description,
    this.picture,
    this.count,
    this.active,
    this.discount,
    this.gst,
    this.hsnCode,
    this.unit,
    this.invoiceId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        weight: json["weight"] ?? "",
        price: json["price"] ?? '',
        quantity: json["quantity"] ?? "",
        description: json["description"] ?? "",
        picture: json["picture"] ?? "",
        count: json["count"] ?? 0,
        active: json["active"] ?? 0,
        discount: json["discount"] ?? 0,
        gst: json["gst"] ?? 0,
        hsnCode: json["hsnCode"] ?? 0,
        unit: json["unit"] ?? "",
        invoiceId: json["invoiceId"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "weight": weight,
        "price": price,
        "quantity": quantity,
        "description": description,
        "picture": picture,
        "count": count,
        "hsnCode": hsnCode,
        "gst": gst,
        "discount": discount,
        "active": active,
        "unit": unit,
        "invoiceId": invoiceId,
      };
}
