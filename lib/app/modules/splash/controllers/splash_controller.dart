import 'package:get/get.dart';
import 'package:kemasindo/app/components/custom_dialog.dart';
import 'package:kemasindo/app/routes/app_pages.dart';

// import '../../../utils/constants.dart';
import '../../../utils/constants.dart';
import '../../login/providers/login_provider.dart';

class SplashController extends GetxController {
  var user = storage.read('userData');
  var session = storage.read('session');

  @override
  void onInit() {
    reqToken();
    Future.delayed(const Duration(seconds: 3), () => autoLogin());
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

  void reqToken() {
    LoginProvider().reqToken('febri', 'febrimobile150708').then((value) {
      print('status_code token : ${value.statusCode}');
      if (value.statusCode == 200) {
        print('token : ${value.body['token']}');

        storage.write('token', value.body['token']);
      } else {
        dialogError('Token Error ${value.statusCode}', '${value.statusText}');
      }
    });
  }

  void autoLogin() {
    if (session != null && session) {
      if (user != null) {
        Get.offNamed(Routes.HOME);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    }
  }

  void onTapLogin() {
    Get.offNamed(Routes.LOGIN);
  }
}
