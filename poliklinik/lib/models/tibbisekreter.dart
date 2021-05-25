import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poliklinik/models/klinik.dart';

import 'doktor.dart';
import 'randevu.dart';
import 'hasta.dart';

class TibbiSekreter {
  List<Hasta> hastalar = [];
  List<Doktor> doktorlar = [];
  List<Randevu> randevular = [];
  final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');
  final _personelColRef = FirebaseFirestore.instance.collection('personeller');
  final _colRandevuRef = FirebaseFirestore.instance.collection('randevular');
  final _colKlinikRef = FirebaseFirestore.instance.collection('klinikler');

  Future<List<Randevu>> randevulariListele() async {
    return (await _colRandevuRef.get())
        .docs
        .map((ds) => Randevu.fromJson(ds.data()))
        .toList();
  }

  Stream<List<Klinik>> tumKlinikiAl() {
    return _colKlinikRef
        .snapshots()
        .map((st) => st.docs.map((e) => Klinik.fromJson(e.data())).toList());
  }

  Stream<List<Doktor>> tumDoktorlariAl() {
    return _personelColRef
        .snapshots()
        .map((st) => st.docs.map((e) => Doktor.fromJson(e.data())).toList());
  }

  randevuEkle(Randevu randevu) {
    randevular.add(randevu);
  }

  randevuSil(Randevu randevu) {
    randevular.remove(randevu);
  }
}
