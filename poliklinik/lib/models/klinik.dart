import 'package:cloud_firestore/cloud_firestore.dart';

class Klinik {
  String? id;
  String? adi;
  String? telNo;

  final colRef = FirebaseFirestore.instance.collection('klinik');

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
    colRef.doc(this.id).set(this.toJson());
  }

  void firebasedenSil() {
    colRef.doc(this.id).delete();
  }
}
