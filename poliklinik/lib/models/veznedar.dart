import 'odeme.dart';

class veznedar {
  String? isim;
  String? soyisim;
  String? telNo;
  
  List<Odeme>? odemeler;

  odemeAl(Odeme odeme) {
    odemeler?.add(odeme);
  }
}
