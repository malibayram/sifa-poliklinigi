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
  Box? testBox;

  late final _personelColRef;

  Personel({this.testBox}) {
    if (testBox == null)
      _personelColRef = FirebaseFirestore.instance.collection('personeller');
  }

  Future<void> girisYap() async {
    String? msg;

    if (email != null && sifre != null) {
      if (testBox == null) {
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email!,
            password: sifre!,
          );
          DocumentSnapshot<Map<String, dynamic>> ds =
              await _personelColRef.doc(userCredential.user?.uid).get();
          if (ds.exists) {
            final p = Personel.fromJson({...(ds.data() as Map), 'id': ds.id});
            this.id = ds.id;
            this.personelTipi = p.personelTipi;
            await Hive.box('ayarlar').put('personel', p.personelTipi);
            await Hive.box('ayarlar').put('personel-id', ds.id);
          } else {
            await _personelColRef.doc(userCredential.user?.uid).set({
              'email': userCredential.user?.email,
              'sifre': sifre,
              'timestamp': FieldValue.serverTimestamp(),
              'personelTipi': 'admin',
            });
          }
        } catch (e) {
          msg = "Giriş Yapılırken hata oluştu: ${e.toString()}";
        }
      } else {
        final testEmailleri = ['deneme@sifa.com', 'istede@sifa.com'];
        final testSifreleri = ['deneme123', 'sifre'];

        final result =
            testEmailleri.contains(email) && testSifreleri.contains(sifre);
        if (result) await testBox!.put('personel', 'denemePersonelTipi');
      }
    } else
      msg = "Email ve şifre boş geçilemez";

    if (msg != null && testBox == null) Fluttertoast.showToast(msg: msg);
  }

  Future<void> cikisYap() async {
    if (testBox == null) await FirebaseAuth.instance.signOut();
    await (testBox ?? Hive.box('ayarlar')).delete('personel');
  }

  Personel.fromJson(Map<String, dynamic>? json) {
    this.id = json?['id'];
    this.personelTipi = json?['personelTipi'];
    this.email = json?['email'];
    this.sifre = json?['sifre'];
    this.isim = json?['isim'];
    this.soyisim = json?['soyisim'];
    this.telNo = json?['tel-no'];
  }

  Map<String, dynamic> toJson() {
    return {
      'personelTipi': this.personelTipi,
      'email': this.email,
      'sifre': this.sifre,
      'isim': this.isim,
      'soyisim': this.soyisim,
      'tel-no': this.telNo,
    };
  }

  Future<String> firebaseEkle() async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: sifre!);

    await _personelColRef.doc(userCredential.user!.uid).set(this.toJson());
    return userCredential.user!.uid;
  }

  Future<void> guncelle() async {
    await _personelColRef.doc(id).set(this.toJson());
  }

  Future<void> firebasedenSil() async {
    if (personelTipi != 'admin')
      await _personelColRef.doc(this.id).delete();
    else
      Fluttertoast.showToast(
          msg: 'Admini Silemezsiniz!', webPosition: 'center');
  }
}
