import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemasindo/app/style/borders.dart';

import '../style/colors.dart';
import '../style/paddings.dart';

void dialogError(String title, String msg) {
  Get.snackbar(title, msg,
      colorText: kErrorColor,
      padding: const EdgeInsets.all(kContentPadding),
      borderRadius: kDefaultBorder,
      borderWidth: 1,
      borderColor: kErrorColor,
      forwardAnimationCurve: Curves.elasticInOut,
      backgroundColor: kWhiteColor.withOpacity(0.5),
      duration: const Duration(seconds: 5),
      icon: const Padding(
        padding: EdgeInsets.all(kContentPadding),
        child: Icon(
          Icons.highlight_off_outlined,
          color: kErrorColor,
          size: 40,
        ),
      ));
}

void dialogWarning(String title, String msg) {
  Get.snackbar(title, msg,
      colorText: kWarningrColor,
      padding: const EdgeInsets.all(kContentPadding),
      borderRadius: kDefaultBorder,
      borderWidth: 1,
      borderColor: kWarningrColor,
      forwardAnimationCurve: Curves.easeInSine,
      backgroundColor: kWhiteColor.withOpacity(0.5),
      duration: const Duration(seconds: 5),
      icon: const Padding(
        padding: EdgeInsets.all(kContentPadding),
        child: Icon(
          Icons.error_outline_outlined,
          color: kWarningrColor,
          size: 40,
        ),
      ));
}

void dialogSuccess(String title, String msg) {
  Get.snackbar(title, msg,
      colorText: kSuccessColor,
      padding: const EdgeInsets.all(kContentPadding),
      borderRadius: kDefaultBorder,
      borderWidth: 1,
      borderColor: kSuccessColor,
      forwardAnimationCurve: Curves.easeOutBack,
      backgroundColor: kWhiteColor.withOpacity(0.5),
      duration: const Duration(seconds: 5),
      icon: const Padding(
        padding: EdgeInsets.all(kContentPadding),
        child: Icon(
          Icons.check_circle_outlined,
          color: kSuccessColor,
          size: 40,
        ),
      ));
}
