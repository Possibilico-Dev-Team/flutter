import 'package:flutter/material.dart';
import 'package:possibilico/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Possibilico'),
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            label: const Text(''),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(child: Text(_auth.currentUser()!.email as String)),
    );
  }
}
