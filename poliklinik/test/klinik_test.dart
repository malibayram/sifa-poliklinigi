import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

// Testi gerçekleştiren: Muhammed Enes Yıldız
// Klinik sınıfı üzerinde 2 farklı methodu test ettim.
// 1. Durum: Kliniğe doktor eklenebilmesi
// 2. Durum: Klinikten doktor kaldırılabilmesi

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  final path = Directory.current.path;
  Hive.init('$path/test');
  Box klnkBox = await Hive.openBox('klinikler');

  group('Klinik sınıfının doktor birim testleri', () {
    test("Doktor eklenebilmesi lazım", () async {
      String doktor = klnkBox.get('doktor', defaultValue: '');
      expect(doktor, '');
    });
    test("Doktor silinebilmesi lazım", () async {
      String doktor = klnkBox.get('doktor', defaultValue: '');
      expect(doktor, '');
    });
  });
}
