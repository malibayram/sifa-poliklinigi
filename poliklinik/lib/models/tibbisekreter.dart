import 'package:cloud_firestore/cloud_firestore.dart';

import 'doktor.dart';
import 'randevu.dart';
import 'hasta.dart';

class TibbiSekreter {
  List<Hasta> hastalar = [];
  List<Doktor> doktorlar = [];
  List<Randevu> randevular = [];
  final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');
  final _colDoktorRef = FirebaseFirestore.instance.collection('doktorlar');
  final _colPersonelRef = FirebaseFirestore.instance.collection('randevular');

  Future<List<Randevu>> randevulariListele() async {
    return (await _colPersonelRef.get())
        .docs
        .map((ds) => Randevu.fromJson(ds.data()))
        .toList();
  }

  Stream<List<Doktor>> tumDoktorlariAl() {
    return _colDoktorRef
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
