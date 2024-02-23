import 'package:flutter/services.dart';

class ProfileModel {
  final int? id;
  final String? name;
  final String? address;
  final String? contact;
  final String? gst;
  late String? customerId;
  final Uint8List? picture;

  ProfileModel({
    this.id,
    this.name,
    this.address,
    this.contact,
    this.gst,
    this.customerId,
    this.picture,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> json) => ProfileModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        address: json["address"] ?? "",
        contact: json["contact"] ?? '',
        gst: json["gst"] ?? '',
        customerId: json["customerId"] ?? "",
        picture: json["picture"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "contact": contact,
        "customerId": customerId,
        "picture": picture,
        "gst": gst,
      };
}
