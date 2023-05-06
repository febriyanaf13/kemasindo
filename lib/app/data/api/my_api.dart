abstract class Api {
  static const baseUrlKetech = 'http://ketechs.freightapp.in/api';
  static const baseUrlKetechBooking = 'http://ketechsbooking.freightapp.in/api';

  static const token = '$baseUrlKetech/login';
  static const login = '$baseUrlKetech/uslogin';
  static const lokasiAbsen = '$baseUrlKetech/get_lokasiabsen';
  static const simpanAbsen = '$baseUrlKetech/simpan_absen';
  static const riwayatAbsenHarian = '$baseUrlKetech/riwayat_absen_harian';
  static const riwayatAbsenBulanan = '$baseUrlKetech/riwayat_absen_bulanan';
  static const riwayatAbsenTahunan = '$baseUrlKetech/riwayat_absen_tahunan';
  static const grafikAbsenBulanan = '$baseUrlKetech/grafik_absen_bulanan';
  static const simpanPermohonanIjin = '$baseUrlKetech/simpan_ijin';
}
