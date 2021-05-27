import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/doktor.dart';
import 'package:poliklinik/models/hasta.dart';
import 'package:poliklinik/models/randevu.dart';

class DoktorPage extends StatefulWidget {
  @override
  _DoktorPageState createState() => _DoktorPageState();
}

class _DoktorPageState extends State<DoktorPage> {
  final TextEditingController _textFieldController = TextEditingController();
  final _doktor = Doktor()..id = Hive.box('ayarlar').get('personel-id');
  List<Hasta> _hastalar = [];
  Hasta _hasta = Hasta();

  _tedaviDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hastanın tedavisini ekleyiniz.'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Tedavi Ekle"),
            ),
            actions: <Widget>[
              new OutlinedButton(
                child: new Text('Kaydet'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _receteDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hastanın reçete bilgisini ekleyiniz.'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Reçete Ekle"),
            ),
            actions: <Widget>[
              new OutlinedButton(
                child: new Text('Kaydet'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _raporDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hastanın rapor bilgisini ekleyiniz.'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "Rapor Ekle"),
            ),
            actions: <Widget>[
              new OutlinedButton(
                child: new Text('Kaydet'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _islemDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Hastanın işlem bilgisini ekleyiniz.'),
            content: TextField(
              controller: _textFieldController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(hintText: "İşlem Ekle"),
            ),
            actions: <Widget>[
              new OutlinedButton(
                child: new Text('Kaydet'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _hastalariGetir() async {
    List<Randevu> randevular = await Randevu.doktorRandevulariniAl(_doktor.id!);
    for (Randevu r in randevular) {
      DocumentSnapshot<Map<String, dynamic>> ds = await FirebaseFirestore
          .instance
          .collection('hastalar')
          .doc(r.hasta)
          .get();
      _hastalar.add(Hasta.fromJson({...ds.data()!, 'id': ds.id}));
    }
    setState(() {});
  }

  @override
  void initState() {
    _hastalariGetir();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var hasta = Hasta();
    final tcNoCtrl = TextEditingController(text: hasta.tcNo);
    final isimCtrl = TextEditingController(text: hasta.isim);
    final sIsimCtrl = TextEditingController(text: hasta.soyisim);
    final adresCtrl = TextEditingController(text: hasta.adres);

    return Scaffold(
      appBar: AppBar(
        title: Text("Doktor Sayfası"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance
                  .signOut()
                  .then((value) => Hive.box('ayarlar').delete('personel'));
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: ListView(
                children: [
                  Center(),
                  for (Hasta hst in _hastalar)
                    Card(
                      child: ListTile(
                        title: Text("${hst.tcNo}"),
                        subtitle: Text("${hst.isim} ${hst.soyisim}"),
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
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: LayoutBuilder(
              builder: (context, constraints) => Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: Column(
                  children: [
                    Center(),
                    TextField(
                      controller: tcNoCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hasta Kimlik Numarası:",
                      ),
                      onChanged: (d) => _hasta.tcNo = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: isimCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın İsmi:",
                      ),
                      onChanged: (d) => _hasta.isim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: sIsimCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Soyismi:",
                      ),
                      onChanged: (d) => _hasta.soyisim = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: adresCtrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Adresi:",
                      ),
                      onChanged: (d) => _hasta.adres = d,
                    ),
                    SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Hastanın Doğum Tarihi:",
                      ),
                      keyboardType: TextInputType.datetime,
                      // onChanged: (d) => _hasta.dogumtarihi = d,
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _hasta.firebaseEkle,
                      child: Text("Güncelle"),
                    ),
                    SizedBox(height: 8),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          OutlinedButton(
                            onPressed: () => _receteDialog(context),
                            child: Text("Reçete Ekle"),
                          ),
                          OutlinedButton(
                            onPressed: () => _raporDialog(context),
                            child: Text("Rapor Ekle"),
                          ),
                          OutlinedButton(
                            onPressed: () => _islemDialog(context),
                            child: Text("İşlem Ekle"),
                          ),
                          OutlinedButton(
                            onPressed: () => _tedaviDialog(context),
                            child: Text("Tedavi Ekle"),
                          ),
                        ])
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
