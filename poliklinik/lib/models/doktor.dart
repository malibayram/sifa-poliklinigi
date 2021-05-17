import 'islem.dart';
import 'recete.dart';
import 'randevu.dart';

class Doktor {
  String? isim;
  String? soyisim;
  String? telno;

  List<Recete>? receteler;
  List<Islem>? islemler;
  List<Randevu>? randevular;

  receteEkle(Recete recete) {
    receteler?.add(recete);
  }

  islemEkle(Islem islem) {
    islemler?.add(islem);
  }

  randevuEkle(Randevu randevu) {
    randevular?.add(randevu);
  }
}
