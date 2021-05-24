import 'package:flutter/material.dart';
import 'models/personel.dart';

class GirisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Personel personel = Personel();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Center(),
            SizedBox(height: 40),
            SizedBox(height: 180, child: Image.asset('assets/logo.png')),
            SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email Adresi",
              ),
              onChanged: (d) => personel.email = d,
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Şifre",
              ),
              obscureText: true,
              onChanged: (d) => personel.sifre = d,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text("Şifremi Unuttum"),
                ),
              ],
            ),
            OutlinedButton(
              onPressed: personel.girisYap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: Text("Giriş Yap"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
