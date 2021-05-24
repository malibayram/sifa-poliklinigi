import 'package:cloud_firestore/cloud_firestore.dart';

import 'personel.dart';
import 'klinik.dart';

class Admin extends Personel {
  List<Personel> personeller = [];
  List<Klinik> klinikler = [];
  final _colRef = FirebaseFirestore.instance.collection('klinikler');

  Stream<List<Klinik>> tumKlinikleriAl() {
    return _colRef
        .snapshots()
        .map((st) => st.docs.map((e) => Klinik.fromJson(e.data())).toList());
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
