import 'package:flutter/material.dart';
import 'package:poliklinik/models/admin.dart';

import '../../models/klinik.dart';

class KlinikTab extends StatelessWidget {
  final Admin admin;
  const KlinikTab({Key? key, required this.admin}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final klinik = Klinik();

    return StreamBuilder<List<Klinik>>(
      stream: admin.tumKlinikleriAl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // ignore: unused_local_variable
          Size screenSize = MediaQuery.of(context).size;

          print(snapshot.data!);

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
                            Card(
                              child: ListTile(
                                title: Text("${klnk.adi}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: klnk.firebasedenSil,
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
                            onChanged: (d) => klinik.id = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Adı:",
                            ),
                            onChanged: (d) => klinik.adi = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Klinik Tel No:",
                            ),
                            keyboardType: TextInputType.phone,
                            onChanged: (d) => klinik.telNo = d,
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
