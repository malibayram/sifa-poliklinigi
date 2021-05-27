<<<<<<< HEAD
import 'package:poliklinik/models/randevu.dart';
=======
//import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> 95bfc6c5f3e7fc17a348a8b81e8e5d8f84bf8c36

import 'hasta.dart';
import 'personel.dart';

class Doktor extends Personel {
<<<<<<< HEAD
  List<Hasta> hastalar = [];
  List<Randevu> randevular = [];
=======
  String? id;
  String? isim;
  String? soyisim;
  String? telNo;

  List<Recete>? receteler;
  List<Islem>? islemler;

  //final _personelColRef = FirebaseFirestore.instance.collection('personeller');
>>>>>>> 95bfc6c5f3e7fc17a348a8b81e8e5d8f84bf8c36

  Doktor();

  Doktor.fromJson(Map<String, dynamic>? json) {
    this.id = json?['id'];
    this.isim = json?['isim'];
    this.soyisim = json?['soyisim'];
    this.telNo = json?['tel-no'];
  }

  Map<String, dynamic> doktorToJson() {
    return {
      ...this.toJson(),
      'hastalar': hastalar.map((e) => e.tcNo).toList(),
    };
  }
}
