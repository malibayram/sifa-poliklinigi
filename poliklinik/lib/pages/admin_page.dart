import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/admin.dart';
import 'admin_tabs/klinik_tab.dart';
import 'admin_tabs/personel_tab.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Admin admin = Admin();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Klinik İşlemleri"),
              Tab(text: "Personel İşlemleri"),
            ],
          ),
          title: Text("Sistem Yönetici Sayfası"),
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
        body: TabBarView(
          children: [
            KlinikTab(admin: admin),
            PersonelTab(admin: admin),
          ],
        ),
      ),
    );
  }
}
