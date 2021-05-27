import 'package:cloud_firestore/cloud_firestore.dart';

import 'hasta.dart';
import 'klinik.dart';
import 'randevu.dart';

class TibbiSekreter {
  List<Klinik> klinikler = [];

  final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');
  final _colKlinikRef = FirebaseFirestore.instance.collection('klinikler');

  Future<Hasta> hastaSorgula(String tcNo) async {
    Hasta hasta = Hasta();
    DocumentSnapshot<Map<String, dynamic>> hDoc =
        await _colHastaRef.doc(tcNo).get();
    if (hDoc.exists) hasta = Hasta.fromJson(hDoc.data()!);

    return hasta;
  }

  List<Randevu> randevulariListele(DateTime simdi) {
    List<Randevu> rList = [];
    int ogledenOnce = 9;
    for (int i = 0; i < 5; i++) {
      Randevu randevu = Randevu();

      randevu.saat = DateTime(
        simdi.year,
        simdi.month,
        simdi.day,
        ogledenOnce + (i / 2).floor(),
        i % 2 == 0 ? 0 : 30,
      );
      rList.add(randevu);
    }

    int ogledenSonra = 13;
    for (int i = 1; i < 5; i++) {
      Randevu randevu = Randevu();
      randevu.saat = DateTime(
        simdi.year,
        simdi.month,
        simdi.day,
        ogledenSonra + (i / 2).floor(),
        i % 2 == 0 ? 0 : 30,
      );
      rList.add(randevu);
    }
    return rList;
  }

  Future<List<Klinik>> tumKlinikiAl() async {
    return (await _colKlinikRef.get())
        .docs
        .map((e) => Klinik.fromJson(e.data()))
        .toList();
  }
}
