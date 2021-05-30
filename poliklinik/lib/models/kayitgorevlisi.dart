//import 'package:cloud_firestore/cloud_firestore.dart';

import 'hasta.dart';

class KayitGorevlisi {
  List<Hasta>? hastalar;
  // final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');

  hastaEkle(Hasta hasta) {
    hastalar?.add(hasta);
  }
}
