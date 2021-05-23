import 'package:cloud_firestore/cloud_firestore.dart';

import 'personel.dart';
import 'klinik.dart';

class Admin extends Personel {
  List<Personel> personeller = [];
  List<Klinik> klinikler = [];
  final colRef = FirebaseFirestore.instance.collection('klinikler');

  Stream<QuerySnapshot<Map<String, dynamic>>> tumKlinikleriAl() {
    return colRef.snapshots();
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
