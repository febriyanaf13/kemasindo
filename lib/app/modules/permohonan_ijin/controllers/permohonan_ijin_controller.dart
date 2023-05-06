import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kemasindo/app/modules/permohonan_ijin/providers/permohonan_ijin_provider.dart';

import '../../../components/custom_dialog.dart';
import '../../../utils/constants.dart';
import '../model/permohonan_ijin.dart';

class PermohonanIjinController extends GetxController {
  //TODO: Implement PermohonanIjinController
  File? imageIjin;
  var boolImageIjin = false.obs;
  final formKey = GlobalKey<FormState>();
  var controllerFrom = ''.obs;
  var controllerTo = ''.obs;
  TextEditingController controllerJenis = TextEditingController();
  TextEditingController controllerAlasan = TextEditingController();
  var userData = storage.read('userData');

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getImageIjin() async {
    try {
      final photo = await ImagePicker().pickImage(source: ImageSource.camera);
      if (photo == null) return;
      final image = File(photo.path);
      imageIjin = image;
      boolImageIjin.toggle();
    } catch (e) {
      dialogError('Error', 'Gagal mengambil gambar : $e');
    }
    update();
  }

  void onTapSimpanIjin() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      var body = PermohonanIjin(
          userid: userData['userid'].toString(),
          from: controllerFrom.value,
          to: controllerTo.value,
          jenis_ijin: controllerJenis.text.toString(),
          alasan: controllerAlasan.text.toString(),
          file_bukti: imageIjin);


      PermohonanIjinProvider()
          .postSimpanPermohonanIjin(body)
          .then((value) => print(value.body));
    }
  }
}
