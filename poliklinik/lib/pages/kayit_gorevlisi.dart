import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/hasta.dart';

class KayitGorevlisi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hasta = Hasta();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Görevlisi Sayfası"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut().then(
                    (value) => Hive.box('ayarlar').delete('personel'),
                  );
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
                child: StreamBuilder<List<Hasta>>(
                  stream: hasta.tumBilgileriniAl(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return ListView(
                        children: [
                          Divider(),
                          for (Hasta hst in snapshot.data!)
                            Card(
                              child: ListTile(
                                title: Text("${hst.tcNo}"),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: hst.firebasedenSil,
                                ),
                              ),
                            ),
                        ],
                      );
                    else
                      return Center(child: CircularProgressIndicator());
                  },
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
                  horizontal: 80,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Center(),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hasta TC NO:",
                      ),
                      onChanged: (d) => hasta.tcNo = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın İsimi:",
                      ),
                      onChanged: (d) => hasta.isim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Soyisimi:",
                      ),
                      onChanged: (d) => hasta.soyisim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Klinik Adresi:",
                      ),
                      onChanged: (d) => hasta.adres = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Doğum Tarihi:",
                      ),
                      keyboardType: TextInputType.datetime,
                      //   onChanged: (d) => hasta.dogumtarihi= d,
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {
                        hasta.firebaseEkle();
                        hasta = Hasta();
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
  }
}
