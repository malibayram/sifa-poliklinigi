import 'package:cloud_firestore/cloud_firestore.dart';

import 'hasta.dart';
import 'klinik.dart';
import 'randevu.dart';

class TibbiSekreter {
<<<<<<< HEAD
  List<Klinik> klinikler = [];

  final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');
=======
  List<Hasta> hastalar = [];
  List<Doktor> doktorlar = [];
  List<Randevu> randevular = [];
  //final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');
  final _personelColRef = FirebaseFirestore.instance.collection('personeller');
  final _colRandevuRef = FirebaseFirestore.instance.collection('randevular');
>>>>>>> 95bfc6c5f3e7fc17a348a8b81e8e5d8f84bf8c36
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
