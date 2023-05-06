import 'package:get/get.dart';
import 'package:kemasindo/app/modules/laporan/models/laporan_bulanan.dart';
import 'package:kemasindo/app/modules/laporan/models/laporan_tahunan.dart';
import 'package:kemasindo/app/modules/laporan/providers/laporan_provider.dart';
import 'package:kemasindo/app/utils/constants.dart';

import '../../../components/custom_dialog.dart';

class LaporanController extends GetxController {
  var currentTabIndex = 0.obs;
  var userData = storage.read('userData');
  int bulanIni = DateTime.now().month;
  int tahunIni = DateTime.now().year;
  var listLaporanBulanan = <LaporanBulanan>[].obs;
  var listLaporanTahunan = <LaporanTahunan>[].obs;

  final data = ['H', 'T', 'I', 'S', 'PA', 'DL', 'A', 'C'];

  @override
  void onInit() {
    super.onInit();
    getLaporanBulanan();
    getLaporanTahunan();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getLaporanBulanan() {
    LaporanProvider()
        .getRiwayatAbsenBulanan(userData['userid'].toString(),
            bulanIni.toString(), tahunIni.toString())
        .then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];

        if (success) {
          var data = body['data'];
          listLaporanBulanan.value =
              laporanBulananFromJson(data).reversed.toList();
        } else {
          dialogWarning('Opss...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Polygon Area');
      }
    });
  }

  void getLaporanTahunan() {
    LaporanProvider()
        .getRiwayatAbsenTahunan(
            userData['userid'].toString(), tahunIni.toString())
        .then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];

        if (success) {
          var data = body['data'];
          listLaporanTahunan.value =
              laporanTahunanFromJson(data).reversed.toList();
        } else {
          dialogWarning('Opss...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Polygon Area');
      }
    });
  }
}
