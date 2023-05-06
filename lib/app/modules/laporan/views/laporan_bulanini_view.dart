import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kemasindo/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:kemasindo/app/style/paddings.dart';
import 'package:timelines/timelines.dart';

import '../../../style/colors.dart';

class LaporanBulaniniView extends GetView<LaporanController> {
  const LaporanBulaniniView({Key? key}) : super(key: key);
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
                  oppositeContentsBuilder: (context, index) {
                    String tglAbsen = DateFormat.d()
                        .format(controller.listLaporanBulanan[index].tglAbsen!);
                    String bulanAbsen = DateFormat.MMM()
                        .format(controller.listLaporanBulanan[index].tglAbsen!);
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: kSubtitlePadding,
                          bottom: kSubtitlePadding,
                          right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tglAbsen),
                          const Divider(
                            height: 2,
                            color: kPrimaryColor,
                          ),
                          Text(bulanAbsen),
                        ],
                      ),
                    );
                  },
                  contentsBuilder: (context, index) {
                    var status = '';
                    Color colors = kPrimaryTextColor;
                    switch (
                        '${controller.listLaporanBulanan[index].statusDatang!} - ${controller.listLaporanBulanan[index].statusPulang!}') {
                      case 'H - P':
                        status = 'Hadir';
                        colors = const Color(0xFF4CAF50);
                        break;

                      case 'T - PA':
                        status = 'Terlambat, Pulang Awal';
                        colors = const Color(0xFF5F5FD2);

                        break;
                      case 'T - P':
                        status = 'Terlambat';
                        colors = const Color(0xFF2196F3);

                        break;

                      case 'H - PA':
                        status = 'Pulang Awal';
                        colors = const Color(0xFF9C27B0);
                        break;

                      case 'A - A':
                        status = 'Alfa';
                        colors = const Color(0xFF000000);

                        break;
                      default:
                    }

                    return Card(
                      child: SizedBox(
                        width: Get.width,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Satatus :',
                                    style: Get.textTheme.subtitle2,
                                  ),
                                  Text(
                                    status,
                                    style: Get.textTheme.subtitle2
                                        ?.copyWith(color: colors),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              height: 2,
                              thickness: 1,
                              indent: 5,
                              endIndent: 5,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        const Text('Datang'),
                                        const SizedBox(height: 5),
                                        Text(controller
                                                    .listLaporanBulanan[index]
                                                    .jamMasuk! ==
                                                ""
                                            ? "-"
                                            : controller
                                                .listLaporanBulanan[index]
                                                .jamMasuk!),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.timer_outlined,
                                    color: kSecondaryColor,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        const Text('Pulang'),
                                        const SizedBox(height: 5),
                                        Text(controller
                                                    .listLaporanBulanan[index]
                                                    .jamPulang! ==
                                                ""
                                            ? "-"
                                            : controller
                                                .listLaporanBulanan[index]
                                                .jamPulang!),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  connectorStyleBuilder: (context, index) =>
                      ConnectorStyle.solidLine,
                  indicatorStyleBuilder: (context, index) =>
                      IndicatorStyle.outlined,
                  itemCount: controller.listLaporanBulanan.length,
                ),
              ),
            )));
  }
}
