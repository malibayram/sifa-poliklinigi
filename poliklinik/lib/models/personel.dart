import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class Personel {
  String? id;
  String? personelTipi;
  String? email;
  String? sifre;
  String? isim;
  String? soyisim;
  String? telNo;

  final _personelColRef = FirebaseFirestore.instance.collection('personeller');

  Personel();

  Future<void> girisYap() async {
    String? msg;
    if (email != null && sifre != null)
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email!,
        password: sifre!,
      )
          .catchError((onError) {
        msg = "Giriş Yapılırken hata oluştu: ${onError.toString()}";
      }).then((userCredential) {
        _personelColRef.doc(userCredential.user?.uid).get().then((ds) {
          if (ds.exists) {
            final p = Personel.fromJson({...(ds.data() as Map), 'id': ds.id});
            this.id = ds.id;
            this.personelTipi = p.personelTipi;
          } else {
            _personelColRef.doc(userCredential.user?.uid).set({
              'email': userCredential.user?.email,
              'sifre': sifre,
              'timestamp': FieldValue.serverTimestamp(),
              'personelTipi': "admin",
            });
          }

          Hive.box('ayarlar').put('personel', "admin");
        });
      });
    else
      msg = "Email ve şifre boş geçilemez";

    if (msg != null) Fluttertoast.showToast(msg: msg!);
  }

  Future<void> cikisYap() async {}

  Personel.fromJson(Map<String, dynamic>? json) {
    this.personelTipi = json?['personelTipi'];
    this.email = json?['email'];
    this.sifre = json?['sifre'];
    this.isim = json?['isim'];
    this.soyisim = json?['soyisim'];
    this.telNo = json?['telNo'];
  }

  Map<String, dynamic> toJson() {
    return {
      'personel-tipi': this.personelTipi,
      'email': this.email,
      'sifre': this.sifre,
      'isim': this.isim,
      'soyisim': this.soyisim,
      'tel-no': this.telNo,
    };
  }

  Future<void> firebaseEkle() async {
    await _personelColRef.doc(this.id).set(this.toJson());
  }

  Future<void> firebasedenSil() async {
    await _personelColRef.doc(this.id).delete();
  }
}
