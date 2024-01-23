import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/manage_products_controller.dart';

class ManageProductsView extends GetView<ManageProductsController> {
  const ManageProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ManageProductsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ManageProductsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
