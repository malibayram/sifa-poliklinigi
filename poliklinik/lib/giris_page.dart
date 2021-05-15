import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class GirisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String? email, sifre;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Center(),
            SizedBox(height: 40),
            SizedBox(height: 180, child: Image.asset('assets/logo.png')),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email Adresi",
              ),
              onChanged: (d) => email = d,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Şifre",
              ),
              obscureText: false,
              onChanged: (d) => sifre = d,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (email != null && sifre != null)
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email!,
                        password: sifre!,
                      )
                          .catchError((onError) {
                        Fluttertoast.showToast(
                            msg:
                                "Giriş Yapılırken hata oluştu: ${onError.toString()}");
                      }).then((userCredential) {
                        FirebaseFirestore.instance
                            .collection('kullanicilar')
                            .doc(userCredential.user?.uid)
                            .set({
                          'email': email,
                          'sifre': sifre,
                          'timestamp': FieldValue.serverTimestamp(),
                          'personel': 'admin',
                        });
                      });
                  },
                  child: Text("Şifremi Unuttum"),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: () {
                if (email != null && sifre != null)
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                    email: email!,
                    password: sifre!,
                  )
                      .catchError((onError) {
                    Fluttertoast.showToast(
                        msg:
                            "Giriş Yapılırken hata oluştu: ${onError.toString()}");
                  }).then((userCredential) {
                    FirebaseFirestore.instance
                        .collection('kullanicilar')
                        .doc(userCredential.user?.uid)
                        .get()
                        .then((documentsnapshot) {
                      Hive.box('ayarlar').put(
                          'personel', documentsnapshot.data()?['personel']);
                    });
                  });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text("Giriş Yap"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
