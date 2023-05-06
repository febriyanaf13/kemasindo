import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemasindo/app/modules/grafik/models/grafik.dart';
import 'package:kemasindo/app/modules/grafik/providers/grafik_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../components/custom_dialog.dart';
import '../../../style/colors.dart';
import '../../../utils/constants.dart';
import '../../laporan/controllers/laporan_controller.dart';
import '../models/kalender_presensi.dart';

class GrafikController extends GetxController {
  int touchedIndex = -1;
  List colorStatus = [
    const Color(0xFF4CAF50),
    const Color(0xFF2196F3),
    const Color(0xFFFF9800),
    const Color(0xFFF44336),
    const Color(0xFF9C27B0),
    const Color(0xFF795548),
    const Color(0xFF474E68),
    const Color(0xFF000000),
  ];

  final laporanC = Get.find<LaporanController>();

  var dataGrafik = <Grafik>[].obs;

  var isLoading = false.obs;
  var listKalenderPresensi = <KalenderPresensi>[].obs;
  var focusedDay = DateTime.now().obs;
  var userData = storage.read('userData');
  int bulanIni = DateTime.now().month;
  int tahunIni = DateTime.now().year;

  @override
  void onInit() {
    getGrafikAbsenBulanan();
    listKalenderPresensi.value = [
      KalenderPresensi(
          tanggal: DateTime.parse("2022-11-15"),
          jamdatang: "09:01",
          jampulang: "16:00",
          statusAbsen: 'Hadir')
    ];
    print(listKalenderPresensi);
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

  setFocusedDay(DateTime day) {
    focusedDay(day);
  }

  getGrafikAbsenBulanan() {
    GrafikProvider()
        .getGrafikAbsenBulanan(userData['userid'].toString(),
            bulanIni.toString(), tahunIni.toString())
        .then((value) {
      if (value.statusCode == 200) {
        var body = value.body;
        var success = body['success'];
        var message = body['message'];

        if (success) {
          print(body['data']);
          var data = body['data'];
          dataGrafik.value = grafikFromJson(data);
        } else {
          dialogWarning('Opss...', message);
        }
      } else {
        dialogError('Error ${value.statusCode}', 'Polygon Area');
      }
    });
  }

  KalenderPresensi getKalenderPresensiFromDay(DateTime day) {
    return listKalenderPresensi.firstWhere(
      (element) => isSameDay(element.tanggal, day),
      orElse: () => KalenderPresensi(
        tanggal: day,
        jamdatang: '-',
        jampulang: '-',
        statusAbsen: '-',
      ),
    );
  }

  List<KalenderPresensi> getEventsForDay(DateTime day) => listKalenderPresensi
      .where((listkal) => isSameDay(day, listkal.tanggal))
      .toList();

  onDaySelected(DateTime selectedDay, DateTime focusedDay) =>
      setFocusedDay(selectedDay);

  KalenderPresensi getKalenderPresensi(DateTime day) {
    return getKalenderPresensiFromDay(day);
  }

  List<PieChartSectionData> showingSections() {
    // print(evaluasiMhsNilai);
    int i = 0;
    var total = 0;

    for (int a = 0; a < dataGrafik.length; a++) {
      total = total + int.parse(dataGrafik[a].jumlah!);
    }

    return dataGrafik.map((e) {
      // final isTouched = i == touchedIndex;
      const fontSize = 13.0;
      const radius = 20.0;
      var color = colorStatus[i];
      var persentase = int.parse(e.jumlah!) / total * 100;
      i++;

      return PieChartSectionData(
        color: color,
        value: double.parse(e.jumlah!),
        radius: radius,
        showTitle: false,
        badgeWidget: Card(
            color: kGreyColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: Text(
                '${persentase.toStringAsFixed(2)}%',
                style: Get.textTheme.subtitle2?.copyWith(fontSize: fontSize),
              ),
            )),
        badgePositionPercentageOffset: 1,
        titleStyle: const TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: kSecondaryTextColor),
      );
    }).toList();
  }

  getDataLaporanTahunan() {
    laporanC.getLaporanTahunan();
  }
}
