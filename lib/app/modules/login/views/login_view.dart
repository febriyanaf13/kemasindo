// ignore_for_file: must_be_immutable

library login;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kemasindo/app/components/custom_button.dart';
import 'package:kemasindo/app/modules/login/providers/login_provider.dart';
import 'package:kemasindo/app/routes/app_pages.dart';
import 'package:kemasindo/app/style/colors.dart';
import 'package:kemasindo/app/utils/extension_image.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:lottie/lottie.dart';

import '../../../components/custom_dialog.dart';
import '../../../data/models/user.dart';
import '../../../utils/constants.dart';

// bindings
part '../bindings/login_binding.dart';

//controllers
part '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: ScreenTypeLayout(
          mobile: _buildMobileScreen(controller),
          tablet: _buildTabletScreen(controller),
          desktop: Container(color: Colors.red),
          watch: Container(color: Colors.purple),
        )));
  }

  /// For Small screens
  Widget _buildMobileScreen(
    LoginController controller,
  ) {
    return Center(
      child: _buildMainBody(
        controller,
      ),
    );
  }

  Widget _buildTabletScreen(LoginController controller) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'assets/coin.json',
              height: Get.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: Get.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(
            controller,
          ),
        ),
      ],
    );
  }

  /// Main Body
  Widget _buildMainBody(
    LoginController simpleUIController,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          Get.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Get.width > 600
            ? Container()
            : Image.asset(
                'logo_login'.png,
                height: Get.height * 0.3,
                width: Get.width,
                fit: BoxFit.scaleDown,
              ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Login',
            style: Get.textTheme.headline3
                ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Welcome Back',
            style: Get.textTheme.headline5?.copyWith(color: kAccentColor),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                /// username or Gmail
                TextFormField(
                  style: kTextFormFieldStyle(),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Username',
                  ),
                  controller: controller.nameController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    } else if (value.length < 3) {
                      return 'at least enter 4 characters';
                    } else if (value.length > 13) {
                      return 'maximum character is 13';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: Get.height * 0.02,
                ),

                /// password
                Obx(
                  () => TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: controller.passwordController,
                    obscureText: controller.isObscure.value,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_open),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isObscure.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.isObscureActive();
                        },
                      ),
                      hintText: 'Password',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      } else if (value.length < 3) {
                        return 'at least enter 6 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Text(
                  'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                  style: Get.textTheme.bodyText2
                      ?.copyWith(color: kSecondaryTextColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),

                /// Login Button
                CustomButton(
                  onTap: controller.onTapLogin,
                  text: "Login",
                  border: 30,
                  height: 50,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          
        },
        child: const Text('Login'),
      ),
    );
  }

  TextStyle kLoginTitleStyle(Size size) => TextStyle(
        fontSize: size.height * 0.060,
        fontWeight: FontWeight.bold,
      );

  TextStyle kLoginSubtitleStyle(Size size) => TextStyle(
        fontSize: size.height * 0.030,
      );

  TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
      TextStyle(fontSize: 15, color: Colors.grey, height: 1.5);

  TextStyle kHaveAnAccountStyle(Size size) =>
      TextStyle(fontSize: size.height * 0.022, color: Colors.black);

  TextStyle kLoginOrSignUpTextStyle(
    Size size,
  ) =>
      TextStyle(
        fontSize: size.height * 0.022,
        fontWeight: FontWeight.w500,
        color: Colors.deepPurpleAccent,
      );

  TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.black);
}
