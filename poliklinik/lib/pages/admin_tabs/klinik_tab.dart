import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KlinikTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('klinikler').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<DocumentSnapshot> personeller = snapshot.data!.docs;

          return ListView(
            children: [
              OutlinedButton(onPressed: () {}, child: Text("Yeni")),
              Divider(),
              for (DocumentSnapshot ds in personeller)
                Card(
                  child: ListTile(
                    title: Text("${(ds.data() as Map)}"),
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
