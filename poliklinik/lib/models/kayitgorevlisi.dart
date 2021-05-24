import 'hasta.dart';

class KayitGorevlisi {
  String? isim;
  String? soyisim;
  String? telno;

  List<Hasta>? hastalar;

  hastaEkle(Hasta hasta) {
    hastalar?.add(hasta);
  }
}
