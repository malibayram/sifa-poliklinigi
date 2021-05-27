import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'doktor.dart';

class Klinik {
  String? id;
  String? adi;
  String? telNo;
  final doktorlar = ValueNotifier<List<Doktor>>([]);

  final _klinikColRef = FirebaseFirestore.instance.collection('klinikler');

  Klinik();

  Klinik.fromJson(Map json) {
    id = json['id'];
    adi = json['adi'];
    telNo = json['tel-no'];

    final doktorColRef = FirebaseFirestore.instance.collection('personeller');

    for (String dId in json['doktorlar']) {
      if (doktorlar.value.where((e) => e.id == dId).length == 0) {
        doktorColRef.doc(dId).get().then((value) {
          doktorlar.value = [
            ...doktorlar.value,
            Doktor.fromJson({...(value.data() as Map), 'id': dId})
          ];
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'adi': adi,
      'tel-no': telNo,
      'doktorlar': doktorlar.value.map((e) => e.id).toList(),
    };
  }

  Future<void> doktorEkle(Doktor doktor) async {
    String dID = await doktor.firebaseEkle();

    doktorlar.value = [...doktorlar.value, doktor];
    await _klinikColRef.doc(id).update({
      'doktorlar': FieldValue.arrayUnion([dID])
    });
  }

  Future<void> doktorSil(Doktor doktor) async {
    await doktor.firebasedenSil();

    doktorlar.value =
        doktorlar.value.where((element) => element.id != doktor.id).toList();

    await _klinikColRef.doc(id).update({
      'doktorlar': FieldValue.arrayRemove([doktor.id])
    });
  }

  Future<void> firebaseEkle() async {
    await _klinikColRef.doc(id).set(toJson());
  }

  void firebasedenSil() {
    _klinikColRef.doc(id).delete();
  }
}
