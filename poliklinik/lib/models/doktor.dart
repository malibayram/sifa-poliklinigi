import 'package:cloud_firestore/cloud_firestore.dart';

import 'islem.dart';
import 'personel.dart';
import 'recete.dart';

class Doktor extends Personel {
  String? id;
  String? isim;
  String? soyisim;
  String? telNo;

  List<Recete>? receteler;
  List<Islem>? islemler;

  final _personelColRef = FirebaseFirestore.instance.collection('personeller');

  Doktor();

  Doktor.fromJson(Map<String, dynamic>? json) {
    this.id = json?['id'];
    this.isim = json?['isim'];
    this.soyisim = json?['soyisim'];
    this.telNo = json?['tel-no'];
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
}
