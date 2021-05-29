import 'package:cloud_firestore/cloud_firestore.dart';

import 'hasta.dart';
import 'odeme.dart';

class Veznedar {
  String? isim;
  String? soyisim;
  String? telNo;

  List<Odeme>? odemeler;

  final _colHastaRef = FirebaseFirestore.instance.collection('hastalar');

  Future<Hasta> hastaSorgula(String tcNo) async {
    Hasta hasta = Hasta();
    DocumentSnapshot<Map<String, dynamic>> hDoc =
        await _colHastaRef.doc(tcNo).get();
    if (hDoc.exists) hasta = Hasta.fromJson(hDoc.data()!);

    return hasta;
  }

  odemeAl(Odeme odeme) {
    odemeler?.add(odeme);
  }
}
