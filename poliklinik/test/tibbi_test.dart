import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/tibbisekreter.dart';

//Testi Gerçekleştiren : Tuğçe Şen
// Tıbbi sekreter modelinde hastaSorgula() fonksiyonu için birim test yaptım.

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final path = Directory.current.path;
  Hive.init('$path/test');
  Box sorguBox = await Hive.openBox('hastalar');

  TibbiSekreter _tibbi = TibbiSekreter(testBox: sorguBox);

  group('Hasta Sorgulama Testi', () {
    test("Hasta Sorgulama", () async {
      await _tibbi.hastaSorgula('111111');
      String hasta = sorguBox.get('hasta', defaultValue: '');
      expect(hasta, '111111');
    });
  });
}
