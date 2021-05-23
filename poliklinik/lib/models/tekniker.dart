import 'islem.dart';

class Tekniker {
  String? isim;
  String? soyisim;
  String? telNo;
  
  List<Islem>? islemler;

  IslemEkle(Islem islem) {
    islemler?.add(islem);
  }
}
