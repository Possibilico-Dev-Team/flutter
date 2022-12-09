import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function? toggleView;
  const SignUp({super.key, this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String passwordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              controller: emailController,
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                errorText: passwordError,
              ),
              controller: passwordController,
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () async {
                dynamic result = await _auth.registerUserWithEmail(
                    emailController.text, passwordController.text);
                if (result is String) {
                  setState(() {
                    passwordError = result;
                  });
                } else if (result is User) {
                  print(result);
                } else {
                  setState(() {
                    passwordError = result.toString();
                  });
                }
              },
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
