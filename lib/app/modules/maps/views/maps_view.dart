// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kemasindo/app/components/custom_lottie.dart';
import 'package:kemasindo/app/routes/app_pages.dart';
import 'package:kemasindo/app/style/paddings.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_dialog.dart';
import '../../../style/colors.dart';
import '../controllers/cek_lokasi.dart';
import '../controllers/maps_controller.dart';

class MapsView extends StatefulWidget {
  const MapsView({super.key});

  @override
  State<MapsView> createState() => _MapsViewState();
}

class _MapsViewState extends State<MapsView> {
  var controller = Get.find<MapsController>();
  var loadingLocation = false;
  var locationServiceEnabled = true;
  bool reloadMaps = false;
  var locationPermissionAllowed = true;

  GoogleMapController? mapController;
  final Map<String, Marker> markers = {};
  final Map<String, Polygon> polygons = {};

  LatLng? centerPosition;

  String? namaGedung;
  late LocationPermission permission;

  Widget _buildGoogleMaps(BuildContext context) => GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: centerPosition!,
          zoom: 16,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
        markers: markers.values.toSet(),
        polygons: polygons.values.toSet(),
      );

  Widget _buildLocationDisable(BuildContext context) => Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Mohon aktfikan lokasi Anda dan izinkan aplikasi untuk mengakses lokasi Anda. Aplikasi harus memastikan apakah Anda berada dalam lokasi Kampus UNISSULA atau tidak. Presensi kehadiran hanya bisa dilakukan di dalam lokasi UNISSULA.',
            textAlign: TextAlign.center,
          ),
        ),
      );

  Widget _buildLoadingCurrentLocation(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customLottie('loading_location'),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Loading Lokasi Terkini',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;

    googleMapsInitilization();
  }

  googleMapsInitilization() {
    if (mounted) {
      setState(() {
        markers.clear();
        markers['Semarang'] = Marker(
          markerId: const MarkerId('Semarang'),
          position: centerPosition!,
          infoWindow: const InfoWindow(
            title: 'Lokasi Anda',
            snippet: 'Lokasi anda terkini',
          ),
        );

        polygons.clear();
        // for (var gedung in listGedungDanKoordinat!) {
        polygons[namaGedung!] = Polygon(
          polygonId: PolygonId(namaGedung!),
          points: controller.listKoorPolygonGedung,
          fillColor: const Color(0xFF1AAC7A).withOpacity(0.3),
          strokeColor: const Color(0xFF1AAC7A),
          strokeWidth: 1,
        );
        // }
      });
    }

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: centerPosition!,
        zoom: 20,
      )),
    );
  }

  checkLocationService() async {
    loadingLocation = true;

    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationServiceEnabled = false;
        loadingLocation = false;
      });
    } else {
      checkLocationPermission();
    }
  }

  checkLocationPermission() async {
    permission = await Geolocator.checkPermission();

    switch (permission) {
      case LocationPermission.denied:
        await Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever) {
            setState(() {
              locationPermissionAllowed = false;
              loadingLocation = false;
            });
          } else {
            getLokasiTerkini();
          }
        });
        break;
      case LocationPermission.deniedForever:
        await Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever) {
            setState(() {
              locationPermissionAllowed = false;
              loadingLocation = false;
            });
          } else {
            getLokasiTerkini();
          }
        });
        break;
      default:
        getLokasiTerkini();
        break;
    }
  }

  getLokasiTerkini() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    if (position.isMocked) {
      controller.showDilarangMenggunakanMockLocaton();
    } else {
      setState(() {
        centerPosition = LatLng(position.latitude, position.longitude);
        loadingLocation = false;
      });
    }
  }

  lokasiTerkiniOnResumed() async {
    if (locationServiceEnabled && locationPermissionAllowed) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      if (position.isMocked) {
        controller.showDilarangMenggunakanMockLocaton();
      } else {
        setState(() {
          centerPosition = LatLng(position.latitude, position.longitude);
          reloadMaps = false;
          loadingLocation = false;
        });
      }
    }
  }

  mapsOnResumed() async {
    bool serviceEnabled;

    if (mounted) {
      setState(() {
        loadingLocation = true;
        reloadMaps = true;
      });
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          reloadMaps = false;
          locationServiceEnabled = false;
          loadingLocation = false;
        });
      }
    } else {
      LocationPermission permission;
      if (mounted) {
        setState(() {
          locationServiceEnabled = true;
        });
      }
      permission = await Geolocator.checkPermission();

      switch (permission) {
        case LocationPermission.denied:
          await Geolocator.requestPermission().then((value) {
            if (value == LocationPermission.denied ||
                value == LocationPermission.deniedForever) {
              if (mounted) {
                setState(() {
                  reloadMaps = false;
                  locationPermissionAllowed = false;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  locationPermissionAllowed = true;
                });
              }
              lokasiTerkiniOnResumed();
            }
          });

          break;
        case LocationPermission.deniedForever:
          await Geolocator.requestPermission().then((value) {
            if (value == LocationPermission.denied ||
                value == LocationPermission.deniedForever) {
              if (mounted) {
                setState(() {
                  reloadMaps = false;
                  locationPermissionAllowed = false;
                  loadingLocation = false;
                });
              }
            } else {
              if (mounted) {
                setState(() {
                  locationPermissionAllowed = true;
                });
              }
              lokasiTerkiniOnResumed();
            }
          });
          break;
        default:
          if (mounted) {
            setState(() {
              locationPermissionAllowed = true;
            });
          }
          lokasiTerkiniOnResumed();
          break;
      }
    }
  }

  onTapPresensiButton() async {
    if (mounted) {
      setState(() {
        controller.loadingAbsen.toggle();
      });
    }
    List<double> listLat = [];
    List<double> listLng = [];

    for (var latlng in controller.listKoorPolygonGedung!) {
      listLat.add(latlng.latitude);
      listLng.add(latlng.longitude);
    }

    CekLokasi cekLokasi = CekLokasi(
      latTitikSekarang: centerPosition!.latitude,
      lngTitikSekarang: centerPosition!.longitude,
      listLatPolygon: listLat,
      listLngPolygon: listLng,
    );

    if (cekLokasi.apakahLokasiDalamPolygon()) {
      controller.postSimpanAbsensi(
          centerPosition!.latitude, centerPosition!.longitude);
    } else {
      dialogWarning('Ops...', 'Maaf, anda tidak dalam wilayah presensi');
      controller.loadingAbsen.toggle();
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    checkLocationService();
    controller.getKoorPolygonArea();

    namaGedung = 'Semarang';

    super.initState();
  }

  @override
  void dispose() {
    mapController!.dispose();
    markers.clear();
    polygons.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        loadingLocation
            ? _buildLoadingCurrentLocation(context)
            : !locationServiceEnabled || !locationPermissionAllowed
                ? _buildLocationDisable(context)
                : _buildGoogleMaps(context),
        Positioned(
          top: 20,
          left: 20,
          right: 20,
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => controller.onTapAccount(),
                      child: Container(
                        width: 40,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kPrimaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              'F',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: Stream.periodic(const Duration(seconds: 1)),
                        builder: (context, snapshot) {
                          return Center(
                            child: Text(
                              DateFormat('HH:mm:ss').format(DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontFamily: 'TickingTimebombBB',
                                      letterSpacing: 10,
                                      fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                    Center(
                      child: GestureDetector(
                        onTap: () => mapsOnResumed(),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: kPrimaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Center(
                          child: Text(
                            'Datang',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: kSuccessColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .005,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Center(
                          child:
                          Obx(() =>  Text(controller.jamMasuk.value == ''? '--:--' : controller.jamMasuk.value,
                              style: Theme.of(context).textTheme.bodyText1),)

                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .02,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Center(
                          child: Text(
                            'Pulang',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(color: kPrimaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * .005,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Center(
                          child: Obx(() =>  Text(controller.jamPulang.value == ''? '--:--' : controller.jamPulang.value,
                              style: Theme.of(context).textTheme.bodyText1),)

                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
        Obx(
          () => Positioned(
            bottom: 90,
            right: Get.width / 10,
            left: Get.width / 10,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      Get.toNamed(Routes.PERMOHONAN_IJIN);
                    },
                    text: "Pengajuan Ijin",
                    border: 30,
                  ),
                ),
                SizedBox(
                  width: kElementPadding,
                ),
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      if (locationServiceEnabled && locationPermissionAllowed) {
                        onTapPresensiButton();
                      } else {
                        dialogWarning('Peringatan',
                            'Layanan lokasi device anda tidak aktif atau aplikasi tidak diizinkan mengakses lokasi Anda.');
                        controller.loadingAbsen.toggle();
                      }
                    },
                    text: controller.loadingAbsen.isTrue
                        ? "Loading..."
                        : "Simpan Absen",
                    border: 30,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
