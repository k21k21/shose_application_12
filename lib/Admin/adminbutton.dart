import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shose_application_12/User/login/view/login.dart';

class buttonadmin extends StatefulWidget {
  const buttonadmin({super.key});

  @override
  State<buttonadmin> createState() => _buttonadminState();
}

class _buttonadminState extends State<buttonadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Page"),
        leading: IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => loginpage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: FloatingActionButton(
              onPressed: () {
                print("Admin FAB pressed");
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
