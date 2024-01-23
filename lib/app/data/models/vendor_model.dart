import 'dart:convert';

VendorModel productModelFromMap(String str) =>
    VendorModel.fromMap(json.decode(str));

String productModelToMap(VendorModel data) => json.encode(data.toMap());

class VendorModel {
  final int? id;
  final String? name;
  final int? mobileNo;
  final String? gst;
  final String? address;

  VendorModel({
    this.id,
    this.name,
    this.mobileNo,
    this.gst,
    this.address,
  });

  factory VendorModel.fromMap(Map<String, dynamic> json) => VendorModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        mobileNo: json["mobileNo"] ?? "",
        gst: json["gst"] ?? "",
        address: json["address"] ?? "",
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "mobileNo": mobileNo,
        "gst": gst,
        "address": address,
      };
}
