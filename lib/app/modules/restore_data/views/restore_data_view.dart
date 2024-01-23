import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/restore_data_controller.dart';

class RestoreDataView extends GetView<RestoreDataController> {
  const RestoreDataView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestoreDataView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RestoreDataView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
