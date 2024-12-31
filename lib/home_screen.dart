import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future registerUser() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      print("User registered: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      log(name: "User registration error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registerUser();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 6,
            ),
            Text("Email"),
            SizedBox(
              height: 6,
            ),
            TextField(
              controller: _emailController,
            ),
            SizedBox(
              height: 6,
            ),
            Text("password"),
            SizedBox(
              height: 6,
            ),
            TextField(
              controller: _passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
