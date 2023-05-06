import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kemasindo/app/utils/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../routes/app_pages.dart';

class AccountController extends GetxController {
  var version = ''.obs;

  @override
  void onInit() {
    getVersionApp();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getVersionApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    version.value = packageInfo.version;
  }

  void onTapLogout() {
    Get.dialog(CupertinoAlertDialog(
      title: const Text("Logout"),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              Get.back();
            },
            child: const Text("Batal")),
        CupertinoDialogAction(
            onPressed: () async {
              await storage.remove('session');
              storage.remove('userData');

              Get.offAllNamed(
                Routes.LOGIN,
              );
            },
            child: const Text("Ya")),
      ],
      content: const Text("Yakin ingin keluar?"),
    ));
  }
}
