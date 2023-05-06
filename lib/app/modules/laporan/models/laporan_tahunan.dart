// To parse this JSON data, do
//
//     final laporanTahunan = laporanTahunanFromJson(jsonString);

import 'dart:convert';

List<LaporanTahunan> laporanTahunanFromJson(List lst) =>
    List<LaporanTahunan>.from(lst.map((x) => LaporanTahunan.fromJson(x)));

String laporanTahunanToJson(List<LaporanTahunan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaporanTahunan {
  LaporanTahunan({
    this.bulan,
    this.tahun,
    this.hadir,
    this.terlambat,
    this.sakit,
    this.ijin,
    this.pulangAwal,
    this.dinasLuar,
    this.alfa,
    this.cuti,
  });

  String? bulan;
  int? tahun;
  int? hadir;
  int? terlambat;
  int? sakit;
  int? ijin;
  int? pulangAwal;
  int? dinasLuar;
  int? alfa;
  int? cuti;

  factory LaporanTahunan.fromJson(Map<String, dynamic> json) => LaporanTahunan(
        bulan: json["bulan"],
        tahun: json["tahun"],
        hadir: json["hadir"],
        terlambat: json["terlambat"],
        sakit: json["sakit"],
        ijin: json["ijin"],
        pulangAwal: json["pulang_awal"],
        dinasLuar: json["dinas_luar"],
        alfa: json["alfa"],
        cuti: json["cuti"],
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "tahun": tahun,
        "hadir": hadir,
        "terlambat": terlambat,
        "sakit": sakit,
        "ijin": ijin,
        "pulang_awal": pulangAwal,
        "dinas_luar": dinasLuar,
        "alfa": alfa,
        "cuti": cuti,
      };
}
