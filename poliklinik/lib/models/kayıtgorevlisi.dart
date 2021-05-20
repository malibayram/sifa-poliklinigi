import 'islem.dart';
import 'recete.dart';
import 'randevu.dart';
import 'hasta.dart';

class kayıtGörevlisi {
  String? isim;
  String? soyisim;
  String? telno;

  List<Recete>? receteler;
  List<Islem>? islemler;
  List<Randevu>? randevular;
  List<Hasta>? hastalar;

  receteEkle(Recete recete) {
    receteler?.add(recete);
  }

  islemEkle(Islem islem) {
    islemler?.add(islem);
  }

  randevuEkle(Randevu randevu) {
    randevular?.add(randevu);
  }
  hastaEkle(Hasta hasta) {
    hastalar?.add(hasta);
  }
}
