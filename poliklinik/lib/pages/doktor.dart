import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Doktor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Doktor Sayfası"),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                FirebaseAuth.instance
                    .signOut()
                    .then((value) => Hive.box('ayarlar').delete('personel'));
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Center(),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Hastanın Kimlik Numarası",
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Hastanın Adı - Soyadı",
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Hastanın Telefon Numarası",
                  ),
                ),
                SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Hastanın Adresi",
                  ),
                ),
                SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("Güncelle"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("Tedavi Bilgisi Ekle"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("Reçete Ekle"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("Rapor Ekle"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("İşlem Talebi Yap"),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Text("Sevk"),
                  ),
                )
              ],
            )));
  }
}

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            constraints: BoxConstraints(
              minHeight: 50.0,
            ),
            child: Text(
              'Top label',
              style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 20,
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemBuilder: (context, index) {
                return Material(
                  child: ListTile(
                    leading: CircleAvatar(),
                    title: Text('Test title'),
                  ),
                );
              },
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: 50.0,
            ),
            child: Center(
              child: Text(
                'Bottom label',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
