import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kemasindo/app/themes/app_theme.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  initializeDateFormatting('id_ID', null).then((_) => runApp(
        GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Kemasindo",
          theme: AppTheme.basic,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      ));
}
