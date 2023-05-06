import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import '../../../style/colors.dart';
import '../../../style/paddings.dart';
import '../controllers/laporan_controller.dart';

class LaporanTahuniniView extends GetView<LaporanController> {
  const LaporanTahuniniView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: const EdgeInsets.only(
                left: kPagePadding,
                right: kPagePadding,
                bottom: kPagePadding + 50),
            child: Obx(
              () => FixedTimeline.tileBuilder(
                theme: TimelineTheme.of(context).copyWith(
                  nodePosition: 0.1,
                  connectorTheme: TimelineTheme.of(context)
                      .connectorTheme
                      .copyWith(thickness: 1.0, color: kAccentColor),
                  indicatorTheme: TimelineTheme.of(context)
                      .indicatorTheme
                      .copyWith(size: 10.0, color: kPrimaryColor),
                ),
                builder: TimelineTileBuilder.connectedFromStyle(
                  contentsAlign: ContentsAlign.basic,
                  oppositeContentsBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 10),
                    child: Text(
                        controller.listLaporanTahunan[index].bulan.toString()),
                  ),
                  contentsBuilder: (context, index) => Card(
                    child: SizedBox(
                        width: Get.width,
                        child: FixedTimeline.tileBuilder(
                          theme: TimelineTheme.of(context).copyWith(
                            nodePosition: 0.05,
                            connectorTheme: TimelineTheme.of(context)
                                .connectorTheme
                                .copyWith(
                                    thickness: 1.0, color: Colors.grey[400]),
                            indicatorTheme: TimelineTheme.of(context)
                                .indicatorTheme
                                .copyWith(size: 10.0, color: kPrimaryColor),
                          ),
                          builder: TimelineTileBuilder.connected(
                            contentsAlign: ContentsAlign.basic,
                            contentsBuilder: (context, i) {
                              var value = 0;
                              var status = '';

                              switch (controller.data[i]) {
                                case 'H':
                                  status = 'Hadir';
                                  value = controller
                                      .listLaporanTahunan[index].hadir!;
                                  break;

                                case 'T':
                                  status = 'Terlambat';
                                  value = controller
                                      .listLaporanTahunan[index].terlambat!;
                                  break;
                                case 'I':
                                  status = 'Ijin';
                                  value = controller
                                      .listLaporanTahunan[index].ijin!;
                                  break;

                                case 'S':
                                  status = 'Sakit';
                                  value = controller
                                      .listLaporanTahunan[index].sakit!;
                                  break;

                                case 'PA':
                                  status = 'Pulang Awal';
                                  value = controller
                                      .listLaporanTahunan[index].pulangAwal!;
                                  break;

                                case 'DL':
                                  status = 'Dinas Luar';
                                  value = controller
                                      .listLaporanTahunan[index].dinasLuar!;
                                  break;

                                case 'A':
                                  status = 'Alfa';
                                  value = controller
                                      .listLaporanTahunan[index].alfa!;

                                  break;case 'C':
                                  status = 'Cuti';
                                  value = controller
                                      .listLaporanTahunan[index].cuti!;

                                  break;
                                default:
                              }

                              return SizedBox(
                                width: Get.width,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(status),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Center(
                                                  child:
                                                      Text(value.toString())),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            connectorBuilder: (_, index, __) {
                              if (index == 0) {
                                return const SolidLineConnector();
                              } else {
                                return const SolidLineConnector();
                              }
                            },
                            indicatorBuilder: (_, index) {
                              switch (controller.data[index]) {
                                case 'H':
                                  return const DotIndicator(
                                    color: Colors.green,
                                    child: Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.white,
                                      size: 10.0,
                                    ),
                                  );
                                case 'T':
                                  return const DotIndicator(
                                    color: Colors.blue,
                                    child: Icon(
                                      Icons.schedule,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                case 'S':
                                  return const DotIndicator(
                                    color: Colors.red,
                                    child: Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                case 'I':
                                  return const DotIndicator(
                                    color: Colors.orange,
                                    child: Icon(
                                      Icons.info_outline_rounded,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                case 'PA':
                                  return const DotIndicator(
                                    color: Colors.purple,
                                    child: Icon(
                                      Icons.run_circle_outlined,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                case 'DL':
                                  return const DotIndicator(
                                    color: Colors.brown,
                                    child: Icon(
                                      Icons.account_circle_outlined,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                case 'A':
                                  return const DotIndicator(
                                    color: Colors.blueGrey,
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );case 'C':
                                  return const DotIndicator(
                                    color: Colors.black,
                                    child: Icon(
                                      Icons.power_settings_new_outlined,
                                      size: 10.0,
                                      color: Colors.white,
                                    ),
                                  );
                                default:
                                  return const OutlinedDotIndicator(
                                    color: Color(0xffbabdc0),
                                    backgroundColor: Color(0xffe6e7e9),
                                  );
                              }
                            },
                            itemCount: controller.data.length,
                          ),
                        )),
                  ),
                  connectorStyleBuilder: (context, index) =>
                      ConnectorStyle.solidLine,
                  indicatorStyleBuilder: (context, index) =>
                      IndicatorStyle.outlined,
                  itemCount: controller.listLaporanTahunan.length,
                ),
              ),
            )));
  }
}
