import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PersonelTab extends StatelessWidget {
  final _colRef = FirebaseFirestore.instance.collection('personeller');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _colRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> personeller = snapshot.data!.docs;

          return ListView(
            children: [
              OutlinedButton(
                onPressed: () {
                  _colRef.add({
                    'isim': "Ahmet",
                    'soyisim': "Bal",
                    'personel': "tekniker",
                  });
                },
                child: Text("Yeni"),
              ),
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
          );
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
