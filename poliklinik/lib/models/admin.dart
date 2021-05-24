import 'package:cloud_firestore/cloud_firestore.dart';

import 'personel.dart';
import 'klinik.dart';

class Admin extends Personel {
  List<Personel> personeller = [];
  List<Klinik> klinikler = [];
  final _colKlinikRef = FirebaseFirestore.instance.collection('klinikler');
  final _colPersonelRef = FirebaseFirestore.instance.collection('personeller');

  Stream<List<Klinik>> tumKlinikleriAl() {
    return _colKlinikRef
        .snapshots()
        .map((st) => st.docs.map((e) => Klinik.fromJson(e.data())).toList());
  }

  Stream<List<Personel>> tumPersonelleriAl() {
    return _colPersonelRef.snapshots().map((st) => st.docs
        .map((ds) => Personel.fromJson({...ds.data(), 'id': ds.id}))
        .toList());
  }

  personelEkle(Personel personel) {
    personeller.add(personel);
  }

  personelSil(Personel personel) {
    personeller.remove(personel);
  }

  klinikEkle(Klinik klinik) {
    klinikler.add(klinik);
  }

  klinikSil(Klinik klinik) {
    klinikler.remove(klinik);
  }
}
