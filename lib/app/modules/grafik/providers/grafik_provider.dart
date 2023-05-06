import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../data/api/my_api.dart';
import '../../../utils/constants.dart';

class GrafikProvider extends GetConnect {
  var token = storage.read('token');

  Future<Response> getGrafikAbsenBulanan(String userId,String bulan, String tahun) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    if (kDebugMode) {
      print('${Api.grafikAbsenBulanan}/$userId/$bulan/$tahun');
    }
    return get('${Api.grafikAbsenBulanan}/$userId/$bulan/$tahun', headers: headers);
  }
}
