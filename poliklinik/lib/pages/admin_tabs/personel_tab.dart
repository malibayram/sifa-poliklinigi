import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poliklinik/models/admin.dart';
import 'package:poliklinik/models/personel.dart';

import '../../models/personel.dart';

class PersonelTab extends StatelessWidget {
  final Admin admin;
  @override
  const PersonelTab({Key? key, required this.admin}) : super(key: key);
  Widget build(BuildContext context) {
    final personel = Personel();
    return StreamBuilder<QuerySnapshot>(
      stream: admin.tumPersonelleriAl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Personel> personeller = snapshot.data!.docs
              .map((e) => Personel.fromJson((e.data() as Map)))
              .toList();

          // ignore: unused_local_variable
          Size screenSize = MediaQuery.of(context).size;

          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: LayoutBuilder(
                    builder: (context, constraints) => Container(
                      child: ListView(
                        children: [
                          Divider(),
                          for (Personel prsnl in personeller)
                            Card(
                              child: ListTile(
                                title: Text("${prsnl.personel}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: prsnl.firebasedenSil,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 40),
                        child: Column(
                          children: [
                            Center(),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Personel:",
                              ),
                              onChanged: (d) => personel.personel = d,
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email:",
                              ),
                              onChanged: (d) => personel.email = d,
                            ),
                            SizedBox(height: 8),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Şifre:",
                              ),
                              onChanged: (d) => personel.sifre = d,
                            ),
                            SizedBox(height: 8),
                            OutlinedButton(
                              onPressed: personel.firebaseEkle,
                              child: Text("Ekle"),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
