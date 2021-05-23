import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:poliklinik/pages/doktor.dart';

class Klinik {
  String? id;
  String? adi;
  String? telNo;
  List<Doktor> doktorlar = [];

  final klinikColRef = FirebaseFirestore.instance.collection('klinikler');
  final doktorColRef = FirebaseFirestore.instance.collection('doktorlar');

  Klinik();

  Klinik.fromJson(Map json) {
    this.id = json['id'];
    this.adi = json['adi'];
    this.telNo = json['tel-no'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'adi': this.adi,
      'tel-no': this.telNo,
    };
  }

  void firebaseEkle() {
    klinikColRef.add(this.toJson());
  }
}
