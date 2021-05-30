import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import '../lib/models/personel.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final path = Directory.current.path;

  Hive.init('$path/test');

  Box ayarBox = await Hive.openBox('ayarlar');

  Personel _personel = Personel(testBox: ayarBox);

  // Testi gerçekleştiren: Mehmet Ali Bayram
  // Personel sınıfı üzerinde 2 farklı methodu 3 durumla test ettim.
  // 1. Durum: yanlış email ve şifre ile girişin yapılamaması
  // 2. Durum: doğru email ve şifre ile girişin yapılabilmesi
  // 3. Durum: çıkış işleminin yapılabilmesi
  group('personel sınıfının birim testleri', () {
    test("Yanlış email ve şifre ikilisi ile giriş yapamaması lazım", () async {
      _personel.email = "mail";
      _personel.sifre = "pass";
      await _personel.girisYap();
      String personel = ayarBox.get('personel', defaultValue: '');
      expect(personel, '');
    });
    test("Doğru email ve şifre ile giriş ikilisi yapaması lazım", () async {
      _personel.email = "deneme@sifa.com";
      _personel.sifre = "deneme123";
      await _personel.girisYap();
      String personel = ayarBox.get('personel', defaultValue: '');
      expect(personel, 'denemePersonelTipi');
    });
    test(
        'Çıkış yapınca giriş bilgilerinin yerel veritabanından silinmesi lazım',
        () async {
      await _personel.cikisYap();
      String personel = ayarBox.get('personel', defaultValue: '');
      expect(personel, '');
    });
  });
}
