import 'odeme.dart';
import 'recete.dart';

class Hasta {
  String? isim;
  String? soyisim;
  String? tcNo;
  DateTime? dogumtarihi;

  List<Recete>? receteler;
  List<Odeme>? odemeler;

  receteEkle(Recete recete) {
    receteler?.add(recete);
  }

  odemeAl(Odeme odeme) {
    odemeler?.add(odeme);
  }
}
