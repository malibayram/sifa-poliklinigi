import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poliklinik/models/hasta.dart';

import 'hasta.dart';

class Randevu {
  DateTime? randevuSaati;
  String? randevuID;
  String? randevualinanklinik;
  String? randevualinandoktor;

  final _colRandevuRef = FirebaseFirestore.instance.collection('randevular');

  Randevu();

  Randevu.fromJson(Map<String, dynamic>? json) {
    this.randevuSaati = json?['randevu-saati'];
    this.randevuID = json?['randevu-id'];
    this.randevualinanklinik = json?['randevu-alinan-klinik'];
    this.randevualinandoktor = json?['randevu-alinan-doktor'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'randevu-saati': this.randevuSaati,
      'randevu-id': this.randevuID,
      'randevu-alinan-klinik': this.randevualinanklinik,
      'randevu-alinan-doktor': this.randevualinandoktor
    };

    /* final _colHastaRef= FirebaseFirestore.instance.collection('hastalar');

    for (String hTc in json['hastalar']) {
      if (hastalar.value.where((e) => e.id == hTc).length == 0) {
        hastaColRef.doc(hTc).get().then((value) {
          hastalar.value = [...hastalar.value, Hasta.fromJson(value.data())];
        });
      }
    } */

    return json;
  }
}
