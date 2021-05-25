import 'package:flutter/material.dart';

import 'package:poliklinik/models/hasta.dart';

class Doktor extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

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
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Hastanın İsmi:",
                            ),
                            onChanged: (d) => hasta.tcNo = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Hastanın Soyismi:",
                            ),
                            onChanged: (d) => hasta.tcNo = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Hastanın Adresi:",
                            ),
                            onChanged: (d) => hasta.tcNo = d,
                          ),
                          SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Hastanın Doğum Tarihi:",
                            ),
                            onChanged: (d) => hasta.tcNo = d,
                          ),
                          SizedBox(height: 8),
                          OutlinedButton(
                            onPressed: hasta.firebaseEkle,
                            child: Text("Güncelle"),
                          ),
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
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
