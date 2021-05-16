import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Veznedar extends StatelessWidget {
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
    );
  }
}
