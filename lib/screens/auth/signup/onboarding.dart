import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    String error = '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            TextField(
              decoration: const InputDecoration(
                hintText: 'First Name',
              ),
              controller: firstNameController,
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Last Name',
                errorText: error,
              ),
              controller: lastNameController,
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            // TODO: Add dropdowns and logic for major and minor selection
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            ElevatedButton(
                child: const Text('Confirm'),
                onPressed: () {
                  // TODO: Add user data upload to firebase database
                  error = 'funny button';
                }),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
