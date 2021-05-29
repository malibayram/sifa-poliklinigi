import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/hasta.dart';
import 'package:poliklinik/models/veznedar.dart';

class VeznedarPage extends StatefulWidget {
  @override
  _VeznedarPageState createState() => _VeznedarPageState();
}

class _VeznedarPageState extends State<VeznedarPage> {
  final Veznedar veznedar = Veznedar();
  Hasta? hasta;
  String _tcNo = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Veznedar Sayfası"),
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
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                  child: Column(
                    children: [
                      Center(),
                      TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Hasta Kimlik Numarası",
                        ),
                      ),
                      SizedBox(height: 8),
                      OutlinedButton(
                        onPressed: () async {
                          if (_tcNo.length > 5)
                            await veznedar.hastaSorgula(_tcNo).then((value) {
                              hasta = value;
                              setState(() {});
                            });
                        },
                        child: Text("Sorgula"),
                      ),
                      Divider(),
                      if (hasta != null)
                        Text(
                          hasta!.isim != null
                              ? "${hasta!.isim} ${hasta!.soyisim}"
                              : "Hasta Bulunamadı! Lütfen hastayı kayıt görevlisine yönlendirin!",
                          style: TextStyle(
                            color:
                                hasta!.isim == null ? Colors.red : Colors.black,
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ))),
          if (hasta?.isim != null)
            Expanded(
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 4,
                        ),
                        children: [],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Fluttertoast.showToast(msg: "Ödeme başarıyla alındı");
                      },
                      child: Text("Ödemeyi Onaya"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
