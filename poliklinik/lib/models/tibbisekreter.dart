import 'randevu.dart';

class TibbiSekreter {
  String? isim;
  String? soyisim;
  String? telno;

  List<Randevu>? randevular;

  randevuEkle(Randevu randevu) {
    randevular?.add(randevu);
  }
}
