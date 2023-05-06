import 'package:get/get.dart';

import '../../../data/api/my_api.dart';
import '../../../utils/constants.dart';

class PermohonanIjinProvider extends GetConnect {
  var token = storage.read('token');

  //post login
  Future<Response> postSimpanPermohonanIjin(data) {
    var headers = {
      "Authorization": "Bearer $token",
    };

    final body = FormData({
      'userid': data.userid,
      'from': data.from,
      'to': data.to,
      'jenis_ijin': data.jenis_ijin,
      'alasan': data.alasan,
      'file_bukti': data.file_bukti ==null?"":MultipartFile(data.file_bukti, filename: '${DateTime.now().toString()}.png'),
    });
    print('ini ${data.from}');

    return post(Api.simpanPermohonanIjin, body, headers: headers);
  }
}
