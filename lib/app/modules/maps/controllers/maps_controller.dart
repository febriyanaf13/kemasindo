import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kemasindo/app/modules/maps/models/lokasi_absen.dart';
import 'package:kemasindo/app/routes/app_pages.dart';
import 'package:kemasindo/app/utils/constants.dart';

import '../../../components/custom_dialog.dart';
import '../providers/maps_provider.dart';

class MapsController extends GetxController {
  var listLokasiAbsen = <LokasiAbsen?>[].obs;
  var loadingAbsen = false.obs;
  var userData = storage.read('userData');
  var token = storage.read('token');
  var listKoorPolygonGedung = <LatLng>[].obs;
  var dateNow = DateFormat('yyyy-MM-dd').format(DateTime.now());
  var jamMasuk = ''.obs;
  var jamPulang = ''.obs;


  @override
  void onInit() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    getRiwayatAbsenHarian();
    super.onInit();
  }

  @override
  void onReady() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  showDilarangMenggunakanMockLocaton() {
    return dialogError('Error',
        'Anda dideteksi menggunakan mock lockator, mohon dinonaktifkan.');
  }

  void getKoorPolygonArea() {
    MapsProvider().getPoligonArea(userData['userid'], token).then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];

        if (success) {
          var data = body['data'];
          listLokasiAbsen.value = lokasiAbsenFromJson(data);
          listKoorPolygonGedung.value = listLokasiAbsen[0]!.geometryAbsen!;
        } else {
          dialogWarning('Opss...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Polygon Area');
      }
    });
  }

  void onTapAccount() {
    Get.toNamed(Routes.ACCOUNT);
  }

  void getRiwayatAbsenHarian() {
    MapsProvider()
        .getRiwayatAbsenHarian(userData['userid'], token, dateNow.toString())
        .then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];

        if (success) {
          var data = body['data'];
          jamMasuk.value = data[0]['jam_masuk'].toString();
          jamPulang.value = data[0]['jam_pulang'].toString();

        } else {
          dialogWarning('Ops...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Polygon Area');
      }
    });
  }

  void postSimpanAbsensi(double lat, double lang) {
    MapsProvider()
        .postSimpanAbsensi(userData['userid'].toString(), lat, lang, token)
        .then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];
        if (success) {
          var data = body['data'];
          dialogSuccess('Status Presensi', message);
          getRiwayatAbsenHarian();
        } else {
          dialogError('Opss...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Simpan Absensi');
      }
      loadingAbsen.toggle();
    });
  }
}
