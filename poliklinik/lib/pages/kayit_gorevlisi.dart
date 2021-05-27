import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/hasta.dart';

class KayitGorevlisi extends StatefulWidget {
  @override
  _KayitGorevlisiState createState() => _KayitGorevlisiState();
  Widget build(BuildContext context) {
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
    );
  }
}

class _KayitGorevlisiState extends State<KayitGorevlisi> {
  var hasta = Hasta();
  @override
  Widget build(BuildContext context) {
    final tcNoCtrl = TextEditingController(text: hasta.tcNo);
    final isimCtrl = TextEditingController(text: hasta.isim);
    final sIsimCtrl = TextEditingController(text: hasta.soyisim);
    final adresCtrl = TextEditingController(text: hasta.adres);

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
                  stream: hasta.tumHastalariGetir(),
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
                                  icon: Icon(Icons.edit),
                                  color: Colors.green,
                                  onPressed: () {
                                    hasta = hasta;
                                    setState(() {});
                                  },
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
                      controller: tcNoCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hasta TC NO:",
                      ),
                      onChanged: (d) => hasta.tcNo = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: isimCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın İsimi:",
                      ),
                      onChanged: (d) => hasta.isim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: sIsimCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Soyisimi:",
                      ),
                      onChanged: (d) => hasta.soyisim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: adresCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Adresi:",
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
                      //  onChanged: (d) => hasta.dogumtarihi= d,
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
