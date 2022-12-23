import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  final Function(User?) onSignOut;

  Homepage({required this.onSignOut});

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    onSignOut(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Welcome User!",
              style: TextStyle(fontSize: 25),
            ),
            Image.asset(
              'images/win.png',
              height: 400,
              width: 400,
              fit: BoxFit.fitWidth,
            ),
            ElevatedButton(
              onPressed: () {
                logout();
              },
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
