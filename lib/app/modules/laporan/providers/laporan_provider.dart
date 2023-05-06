import 'package:get/get.dart';

import '../../../data/api/my_api.dart';
import '../../../utils/constants.dart';

class LaporanProvider extends GetConnect {
  var token = storage.read('token');

  Future<Response> getRiwayatAbsenTahunan(String userId, String tahun) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    return get('${Api.riwayatAbsenTahunan}/$userId/$tahun', headers: headers);
  }

  Future<Response> getRiwayatAbsenBulanan(
      String userId, String bulan, String tahun) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    return get('${Api.riwayatAbsenBulanan}/$userId/$bulan/$tahun',
        headers: headers);
  }
}
