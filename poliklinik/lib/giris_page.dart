import 'package:flutter/material.dart';

class GirisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Şifre",
              ),
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
              onPressed: () {},
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
