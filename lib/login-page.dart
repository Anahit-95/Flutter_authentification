import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  final Function(User?) onSignIn;
  LoginPage({required this.onSignIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String error = '';
  bool login = true;

  Future<void> createUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignIn(userCredential.user);
    } on FirebaseAuthException catch (e) {
      String message = e.message as String;
      setState(() {
        error = message;
      });
    }
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _controllerEmail.text, password: _controllerPassword.text);
      widget.onSignIn(userCredential.user);
    } on FirebaseAuthException catch (e) {
      String message = e.message as String;
      setState(() {
        error = message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              login ? 'Login into your account' : 'Register now',
              style: const TextStyle(fontSize: 20),
            ),
            TextFormField(
              controller: _controllerEmail,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _controllerPassword,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Text(
              error,
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () {
                login ? loginUser() : createUser();
              },
              child: Text(login ? 'Login into account' : 'Sign Up'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                login ? "Don't have one? Register here !" : '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            OutlinedButton(
              onPressed: (() {
                setState(() {
                  login = !login;
                });
              }),
              child: Text(login ? "Sign Up" : "Back to Login page"),
            )
          ],
        ),
      ),
    );
  }
}
