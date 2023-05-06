
import 'dart:io';

import 'package:kemasindo/app/modules/permohonan_ijin/providers/permohonan_ijin_provider.dart';

class PermohonanIjin {
  PermohonanIjin({
    this.userid,
    this.from,
    this.to,
    this.jenis_ijin,
    this.alasan,
    this.file_bukti,
  });

  String? userid;
  String? from;
  String? to;
  String? jenis_ijin;
  String? alasan;
  File? file_bukti;

  factory PermohonanIjin.fromJson(Map<String, dynamic> json) => PermohonanIjin(
    userid: json["userid"],
    from: json["from"],
    to: json["to"],
    jenis_ijin: json["jenis_ijin"],
    alasan: json["alasan"],
    file_bukti: json["file_bukti"],
  );

  get value => null;



  Map<String, dynamic> toJson() => {
    "userid": userid,
    "from": from,
    "to": to,
    "jenis_ijin": jenis_ijin,
    "alasan": alasan,
    "file_bukti": file_bukti,

  };
  }
