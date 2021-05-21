import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonelTab extends StatelessWidget {
  final _colRef = FirebaseFirestore.instance.collection('personeller');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('personeller').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ignore: unused_local_variable
          List<DocumentSnapshot> personeller = snapshot.data!.docs;
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
                          for (DocumentSnapshot ds in personeller)
                            Card(
                              child: ListTile(
                                title: Text("${(ds.data() as Map)}"),
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
                        child: Column(
                          children: [
                            Center(),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Personel ID:",
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Email:",
                              ),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Şifre:",
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _colRef.add({
                                  'Personel ID': "0001",
                                  'Email': "admin@sifa.com",
                                  'Şifre': "admin123",
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
