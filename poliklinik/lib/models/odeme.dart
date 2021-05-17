import 'islem.dart';

class Odeme {
  DateTime? tarih;

  String? isim;
  String? soyisim;
  String? tcNo;
  String? faturaNo;
  double? tutar;

  List<Islem>? islemler;

  islemEkle(Islem islem) {
    islemler?.add(islem);
  }

}

