import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController =
        TextEditingController(text: "zainr8943@gmail.com");
    final TextEditingController passwordController =
        TextEditingController(text: "Smartguy786");

    void login() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      final String email = emailController.text;
      final String password = passwordController.text;

      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      final DocumentSnapshot snapshot =
          await firestore.collection("users").doc(user.user.uid).get();
      final data = snapshot.data();
      Navigator.of(context).pushNamed('/home', arguments: data);
    }

    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: SafeArea(
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter the email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Enter the password'),
                ),
                ElevatedButton(onPressed: login, child: Text("Sign_up"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
