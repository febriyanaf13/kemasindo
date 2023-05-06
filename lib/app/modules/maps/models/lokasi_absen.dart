// To parse this JSON data, do
//
//     final lokasiAbsen = lokasiAbsenFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LokasiAbsen> lokasiAbsenFromJson(List lst) =>
    List<LokasiAbsen>.from(lst.map((x) => LokasiAbsen.fromJson(x)));

String lokasiAbsenToJson(List<LokasiAbsen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LokasiAbsen {
  LokasiAbsen({
    this.namaDivisi,
    this.lokasiAbsen,
    this.geometryLokasi,
    this.geometryAbsen,
  });

  String? namaDivisi;
  String? lokasiAbsen;
  String? geometryLokasi;
  List<LatLng>? geometryAbsen;

  factory LokasiAbsen.fromJson(Map<String, dynamic> json) {
    String strKoordinat = json["geometry_absen"] ?? '(,)';
    List<String> stringlatlngsplitted = strKoordinat.split("),(");
    List<LatLng> listLatLngGedung = [];

    for (var str in stringlatlngsplitted) {
      String removeSquareBracket = str.replaceAll("(", "");
      String removeSquareBracket2 = removeSquareBracket.replaceAll(")", "");
      String removeSpace = removeSquareBracket2.replaceAll(" ", "");
      List<String> strLatLngSplitted = removeSpace.split(",");

      listLatLngGedung.add(LatLng(
        double.parse(strLatLngSplitted[0]),
        double.parse(strLatLngSplitted[1]),
      ));
    }
    return LokasiAbsen(
      namaDivisi: json["nama_divisi"],
      lokasiAbsen: json["lokasi_absen"],
      geometryLokasi: json["geometry_lokasi"],
      geometryAbsen: listLatLngGedung,
    );
  }

  Map<String, dynamic> toJson() => {
        "nama_divisi": namaDivisi,
        "lokasi_absen": lokasiAbsen,
        "geometry_lokasi": geometryLokasi,
        "geometry_absen": geometryAbsen,
      };
}
