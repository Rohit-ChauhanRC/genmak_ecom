import 'dart:io';

import 'package:flutter/services.dart';
import 'package:genmak_ecom/app/data/models/profile_model.dart';
import 'package:genmak_ecom/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileController extends GetxController {
  //

  final HomeController homeController = Get.find<HomeController>();

  final Rx<ProfileModel> _profile = Rx(ProfileModel());
  ProfileModel get profile => _profile.value;
  set profile(ProfileModel v) => _profile.value = v;

  final RxInt _id = 0.obs;
  int get id => _id.value;
  set id(int i) => _id.value = i;

  final RxString _name = ''.obs;
  String get name => _name.value;
  set name(String str) => _name.value = str;

  final RxString _gst = ''.obs;
  String get gst => _gst.value;
  set gst(String str) => _gst.value = str;

  final RxString _address = ''.obs;
  String get address => _address.value;
  set address(String str) => _address.value = str;

  final RxString _contact = ''.obs;
  String get contact => _contact.value;
  set contact(String str) => _contact.value = str;

  final RxString _customerId = ''.obs;
  String get customerId => _customerId.value;
  set customerId(String str) => _customerId.value = str;

  final RxBool _progresBar = RxBool(true);
  bool get progressBar => _progresBar.value;
  set progressBar(bool b) => _progresBar.value = b;

  final RxBool _imageDb = RxBool(true);
  bool get imgeDb => _imageDb.value;
  set imageDb(bool b) => _imageDb.value = b;

  final Rx<Uint8List> _imageLocal = Rx<Uint8List>(Uint8List(0));
  Uint8List get imageLocal => _imageLocal.value;
  set imageLocal(Uint8List pic) => _imageLocal.value = pic;

  @override
  void onInit() async {
    super.onInit();
    await permissionCheck();
    await fetchProfile();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    _address.close();
    _contact.close();
    _customerId.close();
    _name.close();
    _profile.close();
    _gst.close();
  }

  Future<void> permissionCheck() async {
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
  }

  Future<void> fetchProfile() async {
    profile = homeController.profile;

    if (homeController.profile.name != null &&
        homeController.profile.name != "") {
      name = homeController.profile.name!;
      address = homeController.profile.address!;
      contact = homeController.profile.contact!;
      customerId = homeController.profile.customerId!;
      homeController.personPicM = homeController.profile.picture!;
      homeController.memoryImg = true;
      id = homeController.profile.id!;
      gst = homeController.profile.gst!;
      print(homeController.profile.picture);
      print(homeController.profile.id);
      print(homeController.profile.contact);
      print(homeController.profile.address);
      // update();
    }
    progressBar = false;
  }

  Future<void> createProfile() async {
    if (homeController.personPic != null && homeController.personPic != "") {
      await homeController.profileDB
          .create(
              // name: name,
              // address: address,
              // contact: contact,
              // customerId: customerId,
              // gst: gst,
              picture: File(homeController.personPic.path.toString())
                  .readAsBytesSync())
          .then((value) async {
        await homeController.fetchProfile().then((value) => {Get.back()});
      });
    }
  }

  Future<void> updateProfile() async {
    await homeController.profileDB
        .update(
            id: id,
            // name: name,
            // address: address,
            // contact: contact,
            // customerId: customerId,
            // gst: gst,
            picture: (homeController.memoryImg)
                ? homeController.personPicM
                : File(homeController.personPic.path.toString())
                    .readAsBytesSync())
        .then((value) async {
      print("address: $address");
      print("contact: $contact");
      print("id: $id");
      await homeController.fetchProfile().then((value) => {Get.back()});
    });
  }
}
