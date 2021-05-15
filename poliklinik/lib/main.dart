import 'package:flutter/material.dart';

import 'giris_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Şifa Polikliniği',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GirisPage(),
    );
  }
}
