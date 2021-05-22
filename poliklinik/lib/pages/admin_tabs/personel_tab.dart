import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonelTab extends StatelessWidget {
  final _colRef = FirebaseFirestore.instance.collection('kullanicilar');
  String? email, sifre, personel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('kullanicilar').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> kullanicilar = snapshot.data!.docs;
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
                          for (DocumentSnapshot ds in kullanicilar)
                            Card(
                              child: ListTile(
                                title:
                                    Text("${(ds.data() as Map)['personel']}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    _colRef.doc(ds.id).delete();
                                  },
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
                            horizontal: 50, vertical: 50),
                        child: Column(
                          children: [
                            Center(),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Personel:",
                              ),
                              onChanged: (d) => personel = d,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email:",
                              ),
                              onChanged: (d) => email = d,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Şifre:",
                              ),
                              onChanged: (d) => sifre = d,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _colRef.add({
                                  'Personel': personel,
                                  'Email': email,
                                  'Şifre': sifre,
                                });
                              },
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
