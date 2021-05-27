import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:poliklinik/models/admin.dart';
import 'package:poliklinik/pages/admin_tabs/doktor_ekle.dart';

import '../../models/klinik.dart';

class KlinikTab extends StatefulWidget {
  final Admin admin;
  const KlinikTab({Key? key, required this.admin}) : super(key: key);

  @override
  _KlinikTabState createState() => _KlinikTabState();
}

class _KlinikTabState extends State<KlinikTab> {
  var klinik = Klinik();

  @override
  Widget build(BuildContext context) {
    final idCtrl = TextEditingController(text: klinik.id);
    final adiCtrl = TextEditingController(text: klinik.adi);
    final telNoCtrl = TextEditingController(text: klinik.telNo);

    return StreamBuilder<List<Klinik>>(
      stream: widget.admin.tumKlinikleriAl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                          for (Klinik klnk in snapshot.data!)
                            ValueListenableBuilder(
                              valueListenable: klnk.doktorlar,
                              builder: (c, value, w) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DoktorEkle(klinik: klnk),
                                        ),
                                      );
                                    },
                                    title: Text("${klnk.adi}"),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Tel: ${klnk.telNo}"),
                                        Text(
                                          "Doktor Sayısı: ${(value as List).length}",
                                        ),
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
                                              klinik = klnk;
                                              setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            color: Colors.red,
                                            onPressed: () {
                                              if (klnk.doktorlar.value.length >
                                                  0)
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Klinikte doktorlar ekliyken kliniği silemezsiniz.",
                                                );
                                              else
                                                klnk.firebasedenSil();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                            controller: idCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik ID:",
                            ),
                            onChanged: (d) => klinik.id = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: adiCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Adı:",
                            ),
                            onChanged: (d) => klinik.adi = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            controller: telNoCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Tel No:",
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (d) => klinik.telNo = d,
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: () async {
                              await klinik.firebaseEkle();
                              idCtrl.clear();
                              adiCtrl.clear();
                              telNoCtrl.clear();
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
