import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shose_application_12/view/login.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.nightlight_round,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: _isDarkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _isDarkModeEnabled = value;
                  });
                },
              ),
            ),
            const Divider(),

            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.language,
                color: Colors.blueAccent,
                size: 36,
              ),
              title: const Text('Language'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('English', style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 8.0),
                  Icon(Icons.arrow_forward_ios, size: 16.0),
                ],
              ),
              onTap: () {},
            ),
            const SizedBox(height: 30.0),

            Text(
              'Account',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    title: const Text('Delete account'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () {
                      // Handle delete account action
                    },
                  ),
                  const Divider(height: 1, indent: 50, endIndent: 16),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text('Logout'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16.0),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => loginpage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
