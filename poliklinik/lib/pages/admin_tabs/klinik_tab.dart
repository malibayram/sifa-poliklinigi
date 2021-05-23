import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/klinik.dart';

class KlinikTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colRef = FirebaseFirestore.instance.collection('klinik');
    final klinik = Klinik();

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('klinik').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> klinikler = snapshot.data!.docs;
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
                          for (DocumentSnapshot ds in klinikler)
                            Card(
                              child: ListTile(
                                title:
                                    Text("${(ds.data() as Map)['Klinik Adı']}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () {
                                    colRef.doc(ds.id).delete();
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
                          horizontal: 80, vertical: 40),
                      child: Column(
                        children: [
                          Center(),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik ID:",
                            ),
                            onChanged: (d) => klinik.klinikID = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Adı:",
                            ),
                            onChanged: (d) => klinik.klinikAdi = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Tel No:",
                            ),
                            onChanged: (d) => klinik.klinikTel = d,
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: klinik.firebaseEkle,
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
