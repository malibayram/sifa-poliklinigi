import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:poliklinik/models/recete.dart';

class Hasta {
  String? isim;
  String? soyisim;
  String? tcNo;
  String? adres;
  DateTime? dogumtarihi;

  final _hastaColRef = FirebaseFirestore.instance.collection('hastalar');

  Hasta();

  Hasta.fromJson(Map json) {
    isim = json['isim'];
    soyisim = json['soyisim'];
    tcNo = json['tcNo'];
    adres = json['adres'];
    dogumtarihi = json['dogumtarihi'];
  }

  Map<String, dynamic> toJson() {
    return {
      'isim': isim,
      'soyisim': soyisim,
      'tcNo': tcNo,
      'adres': adres,
      'dogumtarihi': dogumtarihi,
    };
  }

  Future<void> receteEkle(Recete recete) async {}

  void firebaseEkle() {
    _hastaColRef.doc(tcNo).set(toJson());
  }

  void firebasedenSil() {
    _hastaColRef.doc(tcNo).delete();
  }
}
