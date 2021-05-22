import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KlinikTab extends StatelessWidget {
  final _colRef = FirebaseFirestore.instance.collection('klinik');
  String? klinikID, klinikAdi, klinikTel;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('klinik').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> klinik = snapshot.data!.docs;
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
                          for (DocumentSnapshot ds in klinik)
                            Card(
                              child: ListTile(
                                title:
                                    Text("${(ds.data() as Map)['Klinik Adı']}"),
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
                              labelText: "Klinik ID:",
                            ),
                            onChanged: (d) => klinikID = d,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Adı:",
                            ),
                            onChanged: (d) => klinikAdi = d,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Tel No:",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              _colRef.add({
                                'Klinik ID': klinikID,
                                'Klinik Adı': klinikAdi,
                                'Klinik Tel No': klinikTel,
                              });
                            },
                            child: Text("Ekle"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
