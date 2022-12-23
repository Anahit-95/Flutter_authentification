import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login-page.dart';
import 'homepage.dart';

class DecisionsTree extends StatefulWidget {
  @override
  State<DecisionsTree> createState() => _DecisionsTreeState();
}

class _DecisionsTreeState extends State<DecisionsTree> {
  User? user;
  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return LoginPage(
        onSignIn: (userCred) => onRefresh(userCred),
      );
    }
    return Homepage(
      onSignOut: (userCred) => onRefresh(userCred),
    );
  }
}
