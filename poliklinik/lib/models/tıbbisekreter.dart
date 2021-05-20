
import 'randevu.dart';


class tıbbiSekreter {
  String? isim;
  String? soyisim;
  String? telno;

  List<Randevu>? randevular;

  randevuEkle(Randevu randevu) {
    randevular?.add(randevu);
  }
  
}
