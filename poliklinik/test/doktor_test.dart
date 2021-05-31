import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/doktor.dart';

//Testi Gerçekleştiren : Öner Aytaş
// Doktor modelinde guncelle() için birim test yaptım.

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final path = Directory.current.path;
  Hive.init('$path/test');
  Box guncelBox = await Hive.openBox('hastalar');

  Doktor doktor = Doktor();

  group('Hasta güncelleme testi', () {
    test("Hasta güncellendi", () async {
      await doktor.guncelle();
      String hasta = guncelBox.get('hasta', defaultValue: '111110');
      expect(hasta, '111111');
    });
  });
}
