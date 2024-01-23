import 'dart:io';

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

  final RxString _name = ''.obs;
  String get name => _name.value;
  set name(String str) => _name.value = str;

  final RxString _address = ''.obs;
  String get address => _address.value;
  set address(String str) => _address.value = str;

  final RxString _contact = ''.obs;
  String get contact => _contact.value;
  set contact(String str) => _contact.value = str;

  final RxString _customerId = ''.obs;
  String get customerId => _customerId.value;
  set customerId(String str) => _customerId.value = str;

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
  }

  Future<void> permissionCheck() async {
    await Permission.camera.request();
    await Permission.mediaLibrary.request();
  }

  Future<void> fetchProfile() async {
    profile = homeController.profile;
    if (profile != null) {
      name = profile.name!;
      address = profile.address!;
      contact = profile.contact!;
      customerId = profile.customerId!;
    }
  }

  Future<void> createProfile() async {
    await homeController.profileDB
        .create(
            name: name,
            address: address,
            contact: contact,
            customerId: customerId,
            picture: File(homeController.personPic.path.toString())
                .readAsBytesSync())
        .then((value) async {
      await homeController.fetchProfile().then((value) => {Get.back()});
    });
  }
}
