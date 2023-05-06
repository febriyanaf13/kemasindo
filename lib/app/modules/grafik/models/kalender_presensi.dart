// To parse this JSON data, do
//
//     final kalenderPresensi = kalenderPresensiFromJson(jsonString);

import 'dart:convert';

List<KalenderPresensi> kalenderPresensiFromJson(String str) => List<KalenderPresensi>.from(json.decode(str).map((x) => KalenderPresensi.fromJson(x)));

String kalenderPresensiToJson(List<KalenderPresensi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KalenderPresensi {
    KalenderPresensi({
        this.tanggal,
        this.statusAbsen,
        this.jamdatang,
        this.jampulang,
    });

    DateTime? tanggal;
    String? statusAbsen;
    String? jamdatang;
    String? jampulang;

    factory KalenderPresensi.fromJson(Map<String, dynamic> json) => KalenderPresensi(
        tanggal: DateTime.parse(json["tanggal"]),
        statusAbsen: json["status_absen"],
        jamdatang: json["jamdatang"],
        jampulang: json["jampulang"],
    );

    Map<String, dynamic> toJson() => {
        "tanggal": "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "status_absen": statusAbsen,
        "jamdatang": jamdatang,
        "jampulang": jampulang,
    };
}
