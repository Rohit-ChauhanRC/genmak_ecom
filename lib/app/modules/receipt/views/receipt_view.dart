import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/receipt_controller.dart';

class ReceiptView extends GetView<ReceiptController> {
  const ReceiptView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReceiptView'),
        centerTitle: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text("Mak Life Dairy Store"),
            ),
            const Align(
              alignment: Alignment.center,
              child: Text("Barnala"),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("GSTIN: aqs221"),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bill No.: 10"),
                  Column(
                    children: [
                      Text("Date: 10/02/24"),
                      Text("Time: 10:56:57"),
                    ],
                  )
                ],
              ),
            ),
            Table(
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    children: const [
                      Text("Sr."),
                      Text("Item Name"),
                      Text("Rate"),
                      Text("Qty"),
                      Text("Value"),
                    ]),
                for (int i = 0; i < controller.orders.toSet().length; i++)
                  TableRow(children: [
                    Text("${i + 1}"),
                    Text("${controller.orders[i].name}"),
                    Text("${controller.orders[i].price}"),
                    Text("${controller.orders[i].count}"),
                    Text("${controller.orders[i].price}"),
                  ]),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Item: ${controller.orders.toSet().length}"),
              const Text("Amount: ₹${500}/-"),
            ]),
            const Align(
              alignment: Alignment.center,
              child: Text("INCLUSIVE OF ALL TAXES"),
            ),
            Table(
              children: [
                TableRow(
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    children: const [
                      Text("Tax%"),
                      Text("B.Amt"),
                      Text("SGST"),
                      Text("CGST"),
                      Text("Total"),
                    ]),
                for (int i = 0; i < controller.orders.toSet().length; i++)
                  TableRow(children: [
                    const Text("${10}"),
                    Text("${controller.orders[i].price}"),
                    const Text("${10}"),
                    const Text("${10}"),
                    const Text("${500}"),
                  ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
