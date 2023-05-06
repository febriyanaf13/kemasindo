// To parse this JSON data, do
//
//     final grafik = grafikFromJson(jsonString);

import 'dart:convert';

List<Grafik> grafikFromJson(List lst) => List<Grafik>.from(lst.map((x) => Grafik.fromJson(x)));

String grafikToJson(List<Grafik> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grafik {
  Grafik({
    this.huruf,
    this.ket,
    this.jumlah,
  });

  String? huruf;
  String? ket;
  String? jumlah;

  factory Grafik.fromJson(Map<String, dynamic> json) => Grafik(
    huruf: json["huruf"],
    ket: json["ket"],
    jumlah: json["jumlah"].toString(),
  );

  Map<String, dynamic> toJson() => {
    "huruf": huruf,
    "ket": ket,
    "jumlah": jumlah,
  };
}
