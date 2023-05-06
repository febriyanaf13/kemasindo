import 'package:flutter/material.dart';
import 'package:kemasindo/app/utils/extension_image.dart';
import 'package:lottie/lottie.dart';

customLottie(String name) {
  return Lottie.asset(
    name.json,
    width: 200,
    height: 200,
    fit: BoxFit.fill,
  );
}
