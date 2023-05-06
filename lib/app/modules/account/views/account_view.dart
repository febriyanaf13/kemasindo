import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kemasindo/app/utils/extension_image.dart';

import '../../../style/colors.dart';
import '../../../style/paddings.dart';
import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: kPagePadding, right: kPagePadding, left: kPagePadding),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: kWhiteColor, width: 5),
                              color: kWhiteColor,
                              image: DecorationImage(
                                  image: AssetImage(
                                    'logo_login'.png,
                                  ),
                                  fit: BoxFit.fill)),
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                          )),
                      const SizedBox(
                        height: kElementPadding,
                      ),
                      Text('Nama',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6),
                      Text('Email@ccc.com',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(color: kPrimaryTextColor)),
                    ],
                  ),
                  const SizedBox(
                    height: kContainerPadding,
                  ),
                  GestureDetector(
                      child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: kDarkGreyColor),
                            const SizedBox(
                              width: kElementPadding,
                            ),
                            Text(
                              'Data Pribadi',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: kPrimaryTextColor),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: kPrimaryTextColor,
                          )
                        ],
                      ))
                    ],
                  )),
                  const SizedBox(
                    height: kElementPadding,
                  ),
                  // GestureDetector(
                  //   onTap: () => Get.toNamed(Routes.OUR_TIM),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Row(
                  //         children: [
                  //           SvgPicture.asset(
                  //               'assets/icons/clarity_users-solid.svg'),
                  //           SizedBox(
                  //             width: kElementPadding,
                  //           ),
                  //           Text(
                  //             'Tim Kami',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1
                  //                 ?.copyWith(color: kSecondaryTextColor),
                  //           )
                  //         ],
                  //       )),
                  //       Expanded(
                  //           child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Icon(
                  //             Icons.keyboard_arrow_right,
                  //             color: kSecondaryTextColor,
                  //           )
                  //         ],
                  //       ))
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: kElementPadding,
                  // ),
                  // GestureDetector(

                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: Row(
                  //         children: [
                  //           SvgPicture.asset('assets/icons/icon-faq.svg'),
                  //           const SizedBox(
                  //             width: kElementPadding,
                  //           ),
                  //           Text(
                  //             'FAQ',
                  //             style: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyText1
                  //                 ?.copyWith(color: kPrimaryTextColor),
                  //           )
                  //         ],
                  //       )),
                  //       Expanded(
                  //           child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.end,
                  //         children: [
                  //           const SizedBox(
                  //             width: 5,
                  //           ),
                  //           const Icon(
                  //             Icons.keyboard_arrow_right,
                  //             color: kPrimaryTextColor,
                  //           )
                  //         ],
                  //       ))
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: kElementPadding,
                  // ),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.logout,
                              color: kErrorColor,
                            ),
                            const SizedBox(
                              width: kElementPadding,
                            ),
                            Text(
                              'Keluar',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: kPrimaryTextColor),
                            ),
                            Expanded(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: kPrimaryTextColor,
                                )
                              ],
                            ))
                          ],
                        ),
                        onTap: () => controller.onTapLogout(),
                      )),
                    ],
                  )
                ],
              ),
            ),
            Obx(() => Positioned(
                bottom: 10,
                right: 20,
                child: Text(
                  'Version ${controller.version}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: kSecondaryTextColor),
                )))
          ],
        ),
      )),
    );
  }
}
