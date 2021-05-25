import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/hasta.dart';

class Doktor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hasta = Hasta();
    return StreamBuilder<List<Hasta>>(
      stream: hasta.tumBilgileriniAl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                          for (Hasta hasta in snapshot.data!)
                            Card(
                              child: ListTile(
                                title: Text("${hasta.tcNo}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: hasta.firebasedenSil,
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
                              labelText: "Hasta Kimlik Numarası:",
                            ),
                            onChanged: (d) => hasta.tcNo = d,
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: hasta.firebaseEkle,
                            child: Text("Sorgula"),
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
