import 'odeme.dart';

class Veznedar {
  String? isim;
  String? soyisim;
  String? telNo;

  List<Odeme>? odemeler;

  odemeAl(Odeme odeme) {
    odemeler?.add(odeme);
  }
}
