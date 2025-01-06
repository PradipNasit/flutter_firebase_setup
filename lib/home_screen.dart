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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          registerUser();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Container(
                height: 50,
                width: 50,
                color: Colors.red,
              ),
            ),
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
