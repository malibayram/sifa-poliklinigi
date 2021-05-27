import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_listener/hive_listener.dart';

import 'giris_page.dart';
import 'pages/admin_page.dart';
import 'pages/doktor_page.dart';
import 'pages/tibbi_sekreter_page.dart';
import 'pages/kayit_gorevlisi.dart';
import 'pages/tekniker.dart';
import 'pages/veznedar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('ayarlar');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Şifa Polikliniği',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HiveListener<dynamic>(
        box: Hive.box('ayarlar'),
        keys: ['tema', 'personel'],
        builder: (box) {
          // print(MediaQuery.of(context).size.width);
          return Center(
            child: FutureBuilder<FirebaseApp>(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                // Check for errors
                if (snapshot.hasError) {
                  return Text("ilklendirme işlemi yapılırken hata oluştu");
                }

                // Once complete, show your application
                if (snapshot.connectionState == ConnectionState.done) {
                  Widget page;
                  switch (box.get('personel')) {
                    case "tibbi-sekreter":
                      page = TibbiSekreterPage();
                      break;

                    case "doktor":
                      page = DoktorPage();
                      break;

                    case "admin":
                      page = AdminPage();
                      break;

                    case "kayit-gorevlisi":
                      page = KayitGorevlisi();
                      break;

                    case "veznedar":
                      page = Veznedar();
                      break;

                    case "tekniker":
                      page = Tekniker();
                      break;

                    default:
                      page = SizedBox(
                        width: MediaQuery.of(context).size.width > 500
                            ? 500
                            : double.maxFinite,
                        child: GirisPage(),
                      );
                  }
                  return page;
                }

                // Otherwise, show something whilst waiting for initialization to complete
                return CircularProgressIndicator();
              },
            ),
          );
        },
      ),
    );
  }
}
