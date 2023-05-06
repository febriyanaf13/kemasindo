import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kemasindo/app/components/custom_datepicker_dialog.dart';
import 'package:kemasindo/app/style/borders.dart';
import 'package:kemasindo/app/style/colors.dart';
import 'package:kemasindo/app/style/paddings.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_dropdown.dart';
import '../controllers/permohonan_ijin_controller.dart';

class PermohonanIjinView extends GetView<PermohonanIjinController> {
  const PermohonanIjinView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Permohonan Ijin'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(kPagePadding),
            child: Column(
              children: [
                Expanded(
                    flex: 15,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: SizedBox(
                          width: Get.size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(kContentPadding),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: '* ',
                                          style: TextStyle(color: kErrorColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Tanggal',
                                                style: TextStyle(
                                                    color: kPrimaryTextColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      CustomDateTimePickerDialog(
                                        text: 'Dari',
                                        onDataChange: (value) {
                                          if (value != null) {
                                            controller.controllerFrom.value =
                                                value;
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Pilih tanggal...!';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        width: kElementPadding / 2,
                                      ),
                                      const Icon(
                                        Icons.date_range_rounded,
                                        size: 20,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(
                                        width: kElementPadding / 2,
                                      ),
                                      CustomDateTimePickerDialog(
                                        text: 'Sampai',
                                        onDataChange: (value) {
                                          if (value != null) {
                                            controller.controllerTo.value =
                                                value;
                                            print(
                                                controller.controllerTo.value);
                                          }
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Pilih tanggal...!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: kElementPadding,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: '* ',
                                          style: TextStyle(color: kErrorColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Jenis Ijin',
                                                style: TextStyle(
                                                    color: kPrimaryTextColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomDropdownButton(
                                    height: 50,
                                    hint: 'Pilih',
                                    items: const [
                                      {'text': 'Ijin', 'value': 'I'},
                                      {'text': 'Cuti', 'value': 'C'}
                                    ],
                                    onChangeValue: (value) {
                                      controller.controllerJenis.text == value;
                                    },
                                    validator: (value) => value == null
                                        ? 'Jenis ijin harus dipilih...!'
                                        : null,
                                  ),
                                  const SizedBox(
                                    height: kElementPadding,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: '* ',
                                          style: TextStyle(color: kErrorColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: 'Alasan',
                                                style: TextStyle(
                                                    color: kPrimaryTextColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                        color: kPrimaryTextColor),
                                    maxLines: 5,
                                    decoration: const InputDecoration(
                                        hintText:
                                            'Tuliskan alasan permohonan ijin...',
                                        hintStyle: TextStyle(
                                            color: kSecondaryTextColor)),
                                    controller: controller.controllerAlasan,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Silahkan masukan alasan permohonan ijin';
                                      } else if (value.length < 3) {
                                        return 'Alasan harus lebih dari 1 suku kata';
                                      } else if (value.length > 100) {
                                        return 'Maksimal karakter adalah 100';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: kElementPadding,
                                  ),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: const TextSpan(
                                          text: '  Bukti ',
                                          style: TextStyle(
                                              color: kPrimaryTextColor,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '(Optional)',
                                                style: TextStyle(
                                                    color: kSecondaryTextColor,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Obx(() =>
                                  GestureDetector(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                          width: Get.width,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                border: Border.all(
                                                    color: kInputBorderColor)),
                                            child: GetBuilder<
                                                PermohonanIjinController>(
                                              builder: (_) {
                                                return controller
                                                        .boolImageIjin.isFalse
                                                    ? Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .add_a_photo_outlined,
                                                            size: 50,
                                                            color:
                                                                kPrimaryColor,
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'Ambil Foto Bukti Ijin',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2
                                                                ?.copyWith(
                                                                    color:
                                                                        kSecondaryTextColor),
                                                          )
                                                        ],
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                kDefaultBorder),
                                                        child: Image.file(
                                                          controller.imageIjin!,
                                                          fit: BoxFit.fitWidth,
                                                        ),
                                                      );
                                              },
                                            ),
                                          ),
                                        ),
                                        controller.boolImageIjin.isFalse
                                            ? const SizedBox()
                                            : const Text(
                                                'Tap untuk mengambil ulang bukti..!')
                                      ],
                                    ),
                                    onTap: () {
                                      controller.getImageIjin();
                                    },
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    )),
                const SizedBox(
                  height: kElementPadding,
                ),
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    onTap: controller.onTapSimpanIjin,
                    text: 'Simpan',
                    border: 30,
                    color: kAccentColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
