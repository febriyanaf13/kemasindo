// To parse this JSON data, do
//
//     final laporanBulanan = laporanBulananFromJson(jsonString);

import 'dart:convert';

List<LaporanBulanan> laporanBulananFromJson(List lst) =>
    List<LaporanBulanan>.from(
        lst.map((x) => LaporanBulanan.fromJson(x)));

String laporanBulananToJson(List<LaporanBulanan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LaporanBulanan {
  LaporanBulanan({
    this.tglAbsen,
    this.statusDatang,
    this.jamMasuk,
    this.statusPulang,
    this.jamPulang,
  });

  DateTime? tglAbsen;
  String? statusDatang;
  String? jamMasuk;
  String? statusPulang;
  String? jamPulang;

  factory LaporanBulanan.fromJson(Map<String, dynamic> json) => LaporanBulanan(
        tglAbsen: DateTime.parse(json["tgl_absen"]),
        statusDatang: json["status_datang"],
        jamMasuk: json["jam_masuk"],
        statusPulang: json["status_pulang"],
        jamPulang: json["jam_pulang"],
      );

  Map<String, dynamic> toJson() => {
        "tgl_absen":
            "${tglAbsen!.year.toString().padLeft(4, '0')}-${tglAbsen!.month.toString().padLeft(2, '0')}-${tglAbsen!.day.toString().padLeft(2, '0')}",
        "status_datang": statusDatang,
        "jam_masuk": jamMasuk,
        "status_pulang": statusPulang,
        "jam_pulang": jamPulang,
      };
}
