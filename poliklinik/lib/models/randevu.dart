import 'package:cloud_firestore/cloud_firestore.dart';

class Randevu {
  DateTime? saat;
  String? hasta;
  String? doktor;

  static final _colRandevuRef =
      FirebaseFirestore.instance.collection('randevular');

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

  static Future<List<Randevu>> doktorRandevulariniAl(String doktorId) async {
    return (await _colRandevuRef.where('doktor', isEqualTo: doktorId).get())
        .docs
        .map((e) => Randevu.fromJson(e.data()))
        .toList();
  }
}
