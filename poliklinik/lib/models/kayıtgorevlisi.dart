
import 'hasta.dart';

class kayıtGörevlisi {
  String? isim;
  String? soyisim;
  String? telno;

  List<Hasta>? hastalar;

  hastaEkle(Hasta hasta) {
    hastalar?.add(hasta);
  }
}
