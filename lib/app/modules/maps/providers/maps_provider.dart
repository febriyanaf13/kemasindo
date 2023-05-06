import 'package:get/get.dart';

import '../../../data/api/my_api.dart';

class MapsProvider extends GetConnect {
  Future<Response> getPoligonArea(int userId, String token) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    return get('${Api.lokasiAbsen}/$userId', headers: headers);
  }

  Future<Response> getRiwayatAbsenHarian(int userId, String token, String date) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    print('${Api.riwayatAbsenHarian}/$date/$userId');
    return get('${Api.riwayatAbsenHarian}/$date/$userId', headers: headers);
  }

  //post login
  Future<Response> postSimpanAbsensi(
      String userId, double lat, double lang, String token) {
    var headers = {
      "Authorization": "Bearer $token",
    };
    final body =
        FormData({'userid': userId, 'lattitude': lat, 'longitude': lang});
    return post(Api.simpanAbsen, body, headers: headers);
  }
}
