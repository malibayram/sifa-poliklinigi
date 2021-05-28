import 'package:flutter/material.dart';

import '../../models/admin.dart';
import '../../models/personel.dart';

class PersonelTab extends StatefulWidget {
  final Admin admin;
  const PersonelTab({Key? key, required this.admin}) : super(key: key);
  @override
  _PersonelTabState createState() => _PersonelTabState();
}

class _PersonelTabState extends State<PersonelTab> {
  var personel = Personel();
  @override
  Widget build(BuildContext context) {
    final isimCtrl = TextEditingController(text: personel.isim);
    final soyIsimCtrl = TextEditingController(text: personel.soyisim);
    final emailCtrl = TextEditingController(text: personel.email);
    final sifreCtrl = TextEditingController(text: personel.sifre);
    final tipiCtrl = TextEditingController(text: personel.personelTipi);
    final telNoCtrl = TextEditingController(text: personel.telNo);

    return StreamBuilder<List<Personel>>(
      stream: widget.admin.tumPersonelleriAl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView(
                    children: [
                      Divider(),
                      for (Personel prsnl in snapshot.data!)
                        Card(
                          child: ListTile(
                            title: Text("${prsnl.personelTipi}"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email: ${prsnl.email}"),
                                Text("Şifre: ${prsnl.sifre}"),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.green,
                                    onPressed: () {
                                      personel = prsnl;
                                      setState(() {});
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: prsnl.firebasedenSil,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 40),
                    child: Column(
                      children: [
                        Center(),
                        TextField(
                          controller: tipiCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Personel Tipi:",
                          ),
                          onChanged: (d) => personel.personelTipi = d,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: isimCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "İsim:",
                          ),
                          onChanged: (d) => personel.isim = d,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: soyIsimCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Soyisim:",
                          ),
                          onChanged: (d) => personel.soyisim = d,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: telNoCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Tel No:",
                          ),
                          onChanged: (d) => personel.telNo = d,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Email:",
                          ),
                          onChanged: (d) => personel.email = d,
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: sifreCtrl,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Şifre:",
                          ),
                          onChanged: (d) => personel.sifre = d,
                        ),
                        SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () async {
                            await personel.firebaseEkle();
                            tipiCtrl.clear();
                            isimCtrl.clear();
                            soyIsimCtrl.clear();
                            emailCtrl.clear();
                            sifreCtrl.clear();
                            telNoCtrl.clear();
                          },
                          child: Text("Ekle"),
                        ),
                      ],
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
