import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.onSignOut,required this.auth}) : super(key: key);
  final AuthBase auth;
  final VoidCallback onSignOut;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          TextButton(
            onPressed: _signOut,
            child: Text(
              'LogOut',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
