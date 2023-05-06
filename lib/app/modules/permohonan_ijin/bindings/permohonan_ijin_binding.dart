import 'package:get/get.dart';

import '../controllers/permohonan_ijin_controller.dart';

class PermohonanIjinBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PermohonanIjinController>(
      () => PermohonanIjinController(),
    );
  }
}
