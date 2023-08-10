import 'package:flutter/material.dart';

import '../style/colors.dart';
import '../style/paddings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final List<Widget>? action;
  final PreferredSize? tabBar;
  final Color? colors;

  const CustomAppBar({
    Key? key,
    this.action,
    this.tabBar,
    this.colors,
  })  : preferredSize = const Size.fromHeight(60),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: kPagePadding),
      //   child: GestureDetector(
      //       onTap: () {
      //         Get.back();
      //       },
      //       child:
      //           SvgPicture.asset('assets/icons/bi_arrow-left-square-fill.svg')),
      // ),

      titleSpacing: kPagePadding,
      backgroundColor: colors ?? kBackgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      automaticallyImplyLeading: false,
      actions: action,
      bottom: tabBar,
    );
  }
}
