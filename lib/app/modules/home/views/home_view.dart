import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kemasindo/app/modules/grafik/views/grafik_view.dart';
import 'package:kemasindo/app/modules/laporan/views/laporan_view.dart';
import 'package:kemasindo/app/modules/maps/views/maps_view.dart';
import 'package:kemasindo/app/style/colors.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: body(context),
        bottomNavigationBar: Obx(
          () => FloatingNavbar(
            onTap: (int val) {
              controller.currentIndex.value = val;
            },
            width: Get.width * .8,
            itemBorderRadius: 30,
            borderRadius: 30,
            backgroundColor: kPrimaryColor,
            selectedItemColor: kSecondaryColor,
            currentIndex: controller.currentIndex.value,
            items: [
              FloatingNavbarItem(
                  icon: Icons.stacked_line_chart_rounded, title: 'Grafik'),
              FloatingNavbarItem(
                  icon: Icons.location_on_rounded, title: 'Maps'),
              FloatingNavbarItem(
                  icon: Icons.list_alt_rounded, title: 'Laporan'),
            ],
          ),
        ));
  }

  Widget body(BuildContext context) => Obx(() {
        switch (controller.currentIndex.value) {
          case 0:
            return const GrafikView();
          case 1:
            return const MapsView();
          default:
            return const LaporanView();
        }
      });
}
