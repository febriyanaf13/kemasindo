import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../style/borders.dart';
import '../../../style/colors.dart';
import '../../../style/paddings.dart';
import '../controllers/grafik_controller.dart';
import '../models/kalender_presensi.dart';

class GrafikView extends GetView<GrafikController> {
  const GrafikView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(kPagePadding),
        child: Column(
          children: [
            Obx(() => kalenderPresensi()),
            const SizedBox(
              height: kElementPadding,
            ),
            Obx(() => SizedBox(
                  child: Column(
                    children: [
                      const Divider(),
                      Text('PRESENTASE ABSEN BULAN INI',
                          style: Get.textTheme.bodyText2
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const Divider(),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kDefaultBorder),
                        ),
                        color: kBoxColor,
                        child:
                            // dataNilai.length == 0
                            //     ? Center(
                            //         child: LottieEmptyData(
                            //           isLoading: simC.isLoadingNilai,
                            //           msg: 'Presentasi rekap nilai kosong...',
                            //         ),
                            //       )
                            //     :
                        SizedBox(
                          height: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(kElementPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: PieChart(
                                          PieChartData(
                                              pieTouchData: PieTouchData(
                                                  touchCallback:
                                                      (FlTouchEvent event,
                                                          pieTouchResponse) {
                                                // setState(() {
                                                //   if (!event
                                                //           .isInterestedForInteractions ||
                                                //       pieTouchResponse == null ||
                                                //       pieTouchResponse
                                                //               .touchedSection ==
                                                //           null) {
                                                //     touchedIndex = -1;
                                                //     return;
                                                //   }
                                                //   touchedIndex = pieTouchResponse
                                                //       .touchedSection!
                                                //       .touchedSectionIndex;
                                                // });
                                              }),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 0,
                                              centerSpaceRadius: 60,
                                              sections:
                                                  controller.showingSections()),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: ListView.separated(
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(
                                              height: 10,
                                            );
                                          },
                                          itemCount:
                                              controller.dataGrafik.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            // return Text('nhuruf');

                                            return Indicator(
                                              color:
                                                  controller.colorStatus[index],
                                              text: controller.dataGrafik[index]
                                                  .huruf,
                                              jumlah:
                                                  '=   ${controller.dataGrafik[index].jumlah}',
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'H = Hadir,   T = Terlambat,   I = Izin,   S = Sakit,\nPA = Pulang Awal,   DL = Dinas Luar,   A = Alfa,   C = Cuti',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: Get.textTheme.bodyText1?.copyWith(
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }

  Widget kalenderPresensi() {
    int tahunIni = DateTime.now().year;
    if (controller.isLoading.value != true) {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              locale: 'id_ID',
              eventLoader: controller.getEventsForDay,
              focusedDay: controller.focusedDay.value,
              selectedDayPredicate: (day) =>
                  isSameDay(controller.focusedDay.value, day),
              onDaySelected: controller.onDaySelected,
              calendarStyle: CalendarStyle(
                  holidayTextStyle: const TextStyle(color: kErrorColor),
                  weekendTextStyle: const TextStyle(color: kErrorColor),
                  selectedDecoration: const BoxDecoration(
                      color: kPrimaryColor, shape: BoxShape.circle),
                  todayDecoration: BoxDecoration(
                      color: kAccentColor.withOpacity(0.5),
                      shape: BoxShape.circle)),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              firstDay: DateTime(tahunIni, 01, 01),
              lastDay: DateTime(tahunIni, 12, 31),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, List<KalenderPresensi> events) {
                  if (events.isEmpty) {
                    return Container();
                  } else {
                    return markerKalender(events);
                  }
                },
              ),
            ),
            controller
                        .getKalenderPresensi(controller.focusedDay.value)
                        .statusAbsen ==
                    '-'
                ? Container()
                : Column(
                    children: [
                      const Divider(),
                      const Text(
                        'RIWAYAT',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(kDefaultBorder),
                        ),
                        color: kBoxColor,
                        child: Padding(
                          padding: const EdgeInsets.all(kElementPadding),
                          child: Row(
                            children: [
                              rowEventKalender(
                                'Status',
                                controller
                                        .getKalenderPresensi(
                                            controller.focusedDay.value)
                                        .statusAbsen ??
                                    '-',
                              ),
                              const SizedBox(height: 5),
                              rowEventKalender(
                                'Datang',
                                controller
                                        .getKalenderPresensi(
                                            controller.focusedDay.value)
                                        .jamdatang ??
                                    'Tidak Absen',
                              ),
                              const VerticalDivider(
                                width: 2,
                              ),
                              controller
                                          .getKalenderPresensi(
                                              controller.focusedDay.value)
                                          .jampulang ==
                                      ":"
                                  ? Container()
                                  : rowEventKalender(
                                      'Pulang',
                                      controller
                                              .getKalenderPresensi(
                                                  controller.focusedDay.value)
                                              .jampulang ??
                                          'Tidak Absen',
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      );
    } else {
      return const Text("Loading");
    }
  }

  Widget markerKalender(List<KalenderPresensi> events) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: events.map((e) {
          switch (e.statusAbsen) {
            case "Alpha":
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                width: 5,
                height: 5,
              );
            case "Terlambat":
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow,
                ),
                width: 5,
                height: 5,
              );
            case "Hadir":
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                width: 5,
                height: 5,
              );
            default:
              return Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                width: 5,
                height: 5,
              );
          }
        }).toList(),
      );

  Widget rowEventKalender(
    String lblData,
    String isiData,
  ) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            lblData,
            style: Get.textTheme.bodyText1,
          ),
          const Text(
            ':',
          ),
          Flexible(
            child: Text(
              isiData,
            ),
          ),
        ],
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final String? text;
  final String? jumlah;
  final Color? color;

  const Indicator({Key? key, this.text, this.color, this.jumlah})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        // const SizedBox(
        //   width: kElementPadding,
        // ),
        Text(text == null ? '-' : text!),
        Text(jumlah == null ? '-' : jumlah!)
      ],
    );
  }
}
