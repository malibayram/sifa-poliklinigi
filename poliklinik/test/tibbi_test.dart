import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:poliklinik/models/tibbisekreter.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final path = Directory.current.path;

  Hive.init('$path/test');

  Box sorguBox = await Hive.openBox('hastalar');

  TibbiSekreter _tibbi = TibbiSekreter(testBox: sorguBox);

  group('Hasta Sorgulama ve Randevu Oluşturma Testleri', () {
    test("Hasta Sorgulama", () async {
      await _tibbi.hastaSorgula('111111');
      String tibbi = sorguBox.get('tibbi', defaultValue: '');
      expect(tibbi, '');
    });
  });
}
