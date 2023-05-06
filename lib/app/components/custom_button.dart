import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double? height;
  final double? width;
  final double border;
  final Color? color;

  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.text,
      this.height,
      this.width,
      required this.border, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      pressEvent: onTap,
      text: text,
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      buttonTextStyle:
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      width: width ?? Get.width,
      height: height ?? Get.height,
      color: color?? kSecondaryColor,
    );
  }
}
