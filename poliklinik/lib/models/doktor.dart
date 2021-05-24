import 'package:cloud_firestore/cloud_firestore.dart';

import 'islem.dart';
import 'recete.dart';

class Doktor {
  String? id;
  String? isim;
  String? soyisim;
  String? telNo;

  List<Recete>? receteler;
  List<Islem>? islemler;

  final _doktorColRef = FirebaseFirestore.instance.collection('doktorlar');

  Doktor.fromJson(Map<String, dynamic>? json) {
    this.isim = json?['isim'];
  }

  receteEkle(Recete recete) {
    receteler?.add(recete);
  }

  islemEkle(Islem islem) {
    islemler?.add(islem);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'isim': this.isim,
      'soyisim': this.soyisim,
      'tel-no': this.telNo,
    };
  }

  Future<void> firebaseEkle() async {
    await _doktorColRef.doc(this.id).set(this.toJson());
  }

  Future<void> firebasedenSil() async {
    await _doktorColRef.doc(this.id).delete();
  }
}
