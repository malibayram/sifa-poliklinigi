import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poliklinik/models/randevu.dart';

import 'hasta.dart';
import 'personel.dart';

class Doktor extends Personel {
  List<Hasta> hastalar = [];
  List<Randevu> randevular = [];

  final _personelColRef = FirebaseFirestore.instance.collection('personeller');

  Doktor();

  Doktor.fromJson(Map<String, dynamic>? json) {
    this.id = json?['id'];
    this.isim = json?['isim'];
    this.soyisim = json?['soyisim'];
    this.telNo = json?['tel-no'];
    this.email = json?['email'];
    this.sifre = json?['sifre'];
  }

  Map<String, dynamic> doktorToJson() {
    return {
      ...this.toJson(),
      'hastalar': hastalar.map((e) => e.tcNo).toList(),
    };
  }

  Future<void> guncelle() async {
    await _personelColRef.doc(id).set(this.toJson());
  }
}
