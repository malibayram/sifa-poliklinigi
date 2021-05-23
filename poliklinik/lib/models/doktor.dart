import 'islem.dart';
import 'recete.dart';

class Doktor {
  String? isim;
  String? soyisim;
  String? telno;

  List<Recete>? receteler;
  List<Islem>? islemler;
  
  receteEkle(Recete recete) {
    receteler?.add(recete);
  }

  islemEkle(Islem islem) {
    islemler?.add(islem);
  }

 
}
