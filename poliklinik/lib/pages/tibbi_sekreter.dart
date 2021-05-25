import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/hasta.dart';

class TibbiSekreter extends StatelessWidget {
  tarihSec(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasta = Hasta();

    return StreamBuilder<List<Hasta>>(
        stream: hasta.tumBilgileriniAl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ignore: unused_local_variable
            Size screenSize = MediaQuery.of(context).size;

            print(snapshot.data!);
            return Scaffold(
              appBar: AppBar(
                title: Text("Tıbbi Sekreter Sayfası"),
                actions: [
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      FirebaseAuth.instance.signOut().then(
                          (value) => Hive.box('ayarlar').delete('personel'));
                    },
                  ),
                ],
              ),
              body: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Container(
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
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            DropdownButton<String>(
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.green),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String? newValue) {
                                {}
                              },
                              items: <String>[
                                'Göz',
                                'Üroloji',
                                'Ortopedi',
                                'Psikiyatri'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            DropdownButton<String>(
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.green),
                              underline: Container(
                                height: 2,
                                color: Colors.blue,
                              ),
                              onChanged: (String? newValue) {
                                {}
                              },
                              items: <String>[
                                'Doktor A',
                                'Doktor B',
                                'Doktor C',
                                'Doktor D'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                            OutlinedButton(
                              onPressed: () => tarihSec(context),
                              child: Text("Tarih Seç"),
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
        });
  }
}
