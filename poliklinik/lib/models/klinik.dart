import 'doktor.dart';


class Klinik {
  String? klinikID;
  String? klinikAdi;
  String? telno;

  List<Doktor>? doktorlar;

  doktorEkle(Doktor doktor) {
    doktorlar?.add(doktor);
  }

}
