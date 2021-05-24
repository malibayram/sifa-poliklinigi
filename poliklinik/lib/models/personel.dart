import 'package:cloud_firestore/cloud_firestore.dart';

class Personel {
  String? personel;
  String? email;
  String? sifre;

  final colRef = FirebaseFirestore.instance.collection('personel');

  Personel();

  Personel.fromJson(Map json) {
    this.personel = json['personel'];
    this.email = json['email'];
    this.sifre = json['sifre'];
  }

  Map<String, dynamic> toJson() {
    return {
      'personel': this.personel,
      'adi': this.email,
      'tel-no': this.sifre,
    };
  }

  void firebaseEkle() {
    colRef.doc(this.personel).set(this.toJson());
  }

  void firebasedenSil() {
    colRef.doc(this.personel).delete();
  }
}
