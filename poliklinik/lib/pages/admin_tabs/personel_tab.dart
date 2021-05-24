import 'package:flutter/material.dart';

import '../../models/admin.dart';
import '../../models/personel.dart';

class PersonelTab extends StatelessWidget {
  final Admin admin;
  const PersonelTab({Key? key, required this.admin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final personel = Personel();
    return StreamBuilder<List<Personel>>(
      stream: admin.tumPersonelleriAl(),
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
                          for (Personel prsnl in snapshot.data!)
                            Card(
                              child: ListTile(
                                title: Text("${prsnl.email}"),
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
                              labelText: "Personel Tipi:",
                            ),
                            onChanged: (d) => personel.personelTipi = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "İsim:",
                            ),
                            onChanged: (d) => personel.isim = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Soyisim:",
                            ),
                            onChanged: (d) => personel.soyisim = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Tel No:",
                            ),
                            onChanged: (d) => personel.telNo = d,
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
