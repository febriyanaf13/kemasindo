import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kemasindo/app/components/custom_button.dart';
import 'package:kemasindo/app/style/colors.dart';
import 'package:kemasindo/app/utils/extension_image.dart';
import 'package:lottie/lottie.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('bg_splash'.png))),
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'logo_splash'.json,
                        width: Get.width * 0.5,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Kemasindo\n',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                              children: [
                            TextSpan(
                              text: 'Aplikasi untuk presensi',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ])),
                    ],
                  ),
                ),
                controller.session == null?
                Expanded(
                    flex: 1,
                    child: Center(
                      child: CustomButton(
                          onTap: controller.onTapLogin,
                          width: 200,
                          height: 50,
                          border: 30,
                          text: 'Login'),
                    )):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
