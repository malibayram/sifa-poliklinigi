<<<<<<< HEAD
import 'package:cloud_firestore/cloud_firestore.dart';
=======
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:poliklinik/models/hasta.dart';

//import 'hasta.dart';
>>>>>>> 95bfc6c5f3e7fc17a348a8b81e8e5d8f84bf8c36

class Randevu {
  DateTime? saat;
  String? hasta;
  String? doktor;

  //final _colRandevuRef = FirebaseFirestore.instance.collection('randevular');

  Randevu();

  Randevu.fromJson(Map<String, dynamic>? json) {
    this.saat = (json?['saati'] as Timestamp).toDate();
    this.hasta = json?['hasta'];
    this.doktor = json?['doktor'];
  }

  Map<String, dynamic> toJson() {
    return {
      'saati': this.saat,
      'hasta': this.hasta,
      'doktor': this.doktor,
    };
  }

  Future<void> onayla(String hastaTcNo, String doktorId) async {
    this.hasta = hastaTcNo;
    this.doktor = doktorId;
    if (this.saat != null) await _colRandevuRef.add(this.toJson());
  }

  Future<List<Randevu>> doktorRandevulariniAl(String doktorId) async {
    return (await _colRandevuRef.where('doktor', isEqualTo: doktorId).get())
        .docs
        .map((e) => Randevu.fromJson(e.data()))
        .toList();
  }
}
