import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/doktor.dart';
import 'package:poliklinik/models/hasta.dart';
import 'package:poliklinik/models/klinik.dart';
import 'package:poliklinik/models/randevu.dart';
import 'package:poliklinik/models/tibbisekreter.dart';

class TibbiSekreterPage extends StatefulWidget {
  @override
  _TibbiSekreterPageState createState() => _TibbiSekreterPageState();
}
// 3454252345

class _TibbiSekreterPageState extends State<TibbiSekreterPage> {
  final TibbiSekreter _sekreter = TibbiSekreter();

  Hasta? _hasta;
  Klinik? _klinik;
  Doktor? _doktor;
  List<Randevu> _randevular = [];
  List<Randevu> _doktorRandevular = [];
  Randevu? _randevu;

  String _tcNo = "";

  tarihSec(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2023),
    ).then((value) {
      if (value != null)
        _randevular = _sekreter.randevulariListele(value);
      else
        _randevular = [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tıbbi Sekreter Sayfası"),
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
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: Column(
                children: [
                  Center(),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Hasta Kimlik Numarası:",
                    ),
                    onChanged: (d) => _tcNo = d,
                  ),
                  SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () {
                      if (_tcNo.length > 5)
                        _sekreter.hastaSorgula(_tcNo).then((value) {
                          _hasta = value;
                          setState(() {});
                        });
                    },
                    child: Text("Sorgula"),
                  ),
                  Divider(),
                  if (_hasta != null)
                    Text(
                      _hasta!.isim != null
                          ? "${_hasta!.isim} ${_hasta!.soyisim}"
                          : "Hasta Bulunamadı! Lütfen hastayı kayıt görevlisine yönlendirin!",
                      style: TextStyle(
                        color: _hasta!.isim == null ? Colors.red : Colors.black,
                        fontSize: 20,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (_hasta?.isim != null)
            Expanded(
              child: Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
                child: Column(
                  children: <Widget>[
                    FutureBuilder<List<Klinik>>(
                      future: _sekreter.tumKlinikiAl(),
                      builder: (context, snapshot) {
                        print(snapshot);
                        if (snapshot.hasData)
                          return DropdownButton<Klinik>(
                            hint: Text(
                              _klinik != null ? _klinik!.adi! : "Klinik Seç",
                            ),
                            // value: _klinik,
                            onChanged: (v) {
                              _klinik = v;
                              _doktor = null;
                              _randevu = null;
                              _randevular = [];
                              _doktorRandevular = [];
                              setState(() {});
                            },
                            items: [
                              for (Klinik k in snapshot.data!)
                                DropdownMenuItem(
                                  value: k,
                                  child: Center(child: Text(k.adi!)),
                                ),
                            ],
                          );
                        else
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                      },
                    ),
                    if (_klinik != null)
                      ValueListenableBuilder<List<Doktor>>(
                        valueListenable: _klinik!.doktorlar,
                        builder: (c, value, w) {
                          return DropdownButton<Doktor>(
                            hint: Text(
                              _doktor != null ? _doktor!.isim! : "Doktor Seç",
                            ),
                            // value: _klinik,
                            onChanged: (v) {
                              _doktor = v;
                              _randevu = null;
                              _randevular = [];
                              _doktorRandevular = [];
                              Randevu()
                                ..doktorRandevulariniAl(v!.id!).then((value) {
                                  _doktorRandevular = value;
                                  setState(() {});
                                });

                              setState(() {});
                            },
                            items: [
                              for (Doktor d in value)
                                DropdownMenuItem(
                                  value: d,
                                  child: Center(child: Text(d.isim!)),
                                ),
                            ],
                          );
                        },
                      ),
                    if (_doktor != null)
                      OutlinedButton(
                        onPressed: () => tarihSec(context),
                        child: Text("Tarih Seç"),
                      ),
                    if (_randevular.length > 0)
                      Expanded(
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4,
                          ),
                          children: [
                            for (Randevu r in _randevular)
                              RadioListTile<Randevu>(
                                title: Text(
                                    "${r.saat!.hour}:${r.saat!.minute == 0 ? '00' : '30'}"),
                                value: r,
                                groupValue: _randevu,
                                onChanged: _doktorRandevular
                                        .map((t) => t.saat)
                                        .contains(r.saat)
                                    ? null
                                    : (v) {
                                        _randevu = v;
                                        setState(() {});
                                      },
                              ),
                          ],
                        ),
                      ),
                    if (_randevu != null)
                      OutlinedButton(
                        onPressed: () {
                          _randevu!
                              .onayla(_hasta!.tcNo!, _doktor!.id!)
                              .then((value) {
                            _klinik = null;
                            _hasta = null;
                            setState(() {});
                            Fluttertoast.showToast(
                                msg: "Randevu başarıyla oluşturuldu");
                          });
                        },
                        child: Text("Randuvuyu Onaya"),
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
