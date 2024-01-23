import 'product_model.dart';

class ReceivingModel {
  int? id;
  String? invoiceId;
  String? vendorName;
  String? vendorId;
  String? totalAmount;
  String? productName;
  String? productId;
  String? productQuantity;
  String? receivingDate;
  ProductModel? productModel;
  ReceivingModel({
    this.id,
    this.vendorName,
    this.vendorId,
    this.invoiceId,
    this.totalAmount,
    this.productName,
    this.productId,
    this.receivingDate,
    this.productQuantity,
    this.productModel,
  });

  factory ReceivingModel.fromMap(Map<String, dynamic> json) => ReceivingModel(
        id: json["id"] ?? 0,
        invoiceId: json["invoiceId"] ?? "",
        vendorName: json["vendorName"] ?? "",
        vendorId: json["vendorId"] ?? '',
        productName: json["productName"] ?? "",
        productId: json["productId"] ?? "",
        totalAmount: json["totalAmount"] ?? "",
        productQuantity: json["productQuantity"].toString() ?? "",
        receivingDate: json["receivingDate"] ?? "",
        productModel: json["productModel"] ?? ProductModel(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "invoiceId": invoiceId,
        "vendorName": vendorName,
        "vendorId": vendorId,
        "productName": productName,
        "productId": productId,
        "totalAmount": totalAmount,
        "productQuantity": productQuantity,
        "receivingDate": receivingDate,
        "productModel": productModel,
      };
}
