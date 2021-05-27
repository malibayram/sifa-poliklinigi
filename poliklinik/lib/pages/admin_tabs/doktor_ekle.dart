import 'package:flutter/material.dart';
import 'package:poliklinik/models/doktor.dart';
import 'package:poliklinik/models/klinik.dart';

class DoktorEkle extends StatefulWidget {
  final Klinik klinik;

  const DoktorEkle({Key? key, required this.klinik}) : super(key: key);
  @override
  _DoktorEkleState createState() => _DoktorEkleState();
}

class _DoktorEkleState extends State<DoktorEkle> {
  var doktor = Doktor()..personelTipi = 'doktor';

  @override
  Widget build(BuildContext context) {
    final isimCtrl = TextEditingController(text: doktor.isim);
    final soyIsimCtrl = TextEditingController(text: doktor.soyisim);
    final emailCtrl = TextEditingController(text: doktor.email);
    final sifreCtrl = TextEditingController(text: doktor.sifre);
    final telNoCtrl = TextEditingController(text: doktor.telNo);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.klinik.adi!),
      ),
      body: Row(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: widget.klinik.doktorlar,
              builder: (c, value, w) {
                return ListView(
                  children: [
                    for (Doktor dktr in (value as List<Doktor>))
                      Card(
                        child: ListTile(
                          title: Text("${dktr.isim} ${dktr.soyisim}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Tel: ${dktr.telNo}"),
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
                                    doktor = dktr;
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () =>
                                      widget.klinik.doktorSil(dktr),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
              child: Column(
                children: [
                  Text(
                    "Doktor Ekle",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(),
                  Center(),
                  TextField(
                    controller: isimCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "İsim:",
                    ),
                    onChanged: (d) => doktor.isim = d,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: soyIsimCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Soyisim:",
                    ),
                    onChanged: (d) => doktor.soyisim = d,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: telNoCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Tel No:",
                    ),
                    onChanged: (d) => doktor.telNo = d,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: emailCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email:",
                    ),
                    onChanged: (d) => doktor.email = d,
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: sifreCtrl,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Şifre:",
                    ),
                    onChanged: (d) => doktor.sifre = d,
                  ),
                  SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: () => widget.klinik
                        .doktorEkle(doktor)
                        .whenComplete(() => setState(() {})),
                    child: Text("Ekle"),
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
