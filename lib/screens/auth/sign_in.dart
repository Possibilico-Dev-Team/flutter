import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/screens/auth/signup/sign_up.dart';
import 'package:possibilico/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Image(image: AssetImage('assets/PossibilicoLogo.png')),
            const Spacer(),
            const Text(
              'Log In',
              style: TextStyle(fontSize: 28.0),
            ),
            const Padding(padding: EdgeInsets.only(top: 20.0)),
            const Text('Email'),
            TextField(
              decoration: InputDecoration(
                hintText: 'example@utrgv.edu',
                errorText: emailError,
              ),
              controller: emailController,
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            const Text('Password'),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'ABCD1234!',
                errorText: passwordError,
              ),
              controller: passwordController,
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50.0),
                  backgroundColor: const Color(0xFF5A6499)),
              child: const Text('Log In'),
              onPressed: () async {
                if (emailController.text.isEmpty) {
                  setState(() {
                    emailError = 'Email cannot be blank';
                  });
                }
                if (passwordController.text.isEmpty) {
                  setState(() {
                    passwordError = 'Password cannot be blank';
                  });
                }
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  dynamic result = await _auth.signInWithEmail(
                      emailController.text, passwordController.text);
                  if (result is String) {
                    setState(() {
                      passwordError = result;
                    });
                  } else if (result is User) {
                    print('Sign in: $result');
                  } else {
                    setState(() {
                      passwordError = result.toString();
                    });
                  }
                }
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            InkWell(
              child: const Text(
                "Don't have an account? Sign Up!",
                style: TextStyle(color: Color(0xFF5A6499)),
              ),
              onTap: () => {widget.toggleView!()},
            ),
          ],
        ),
      ),
    );
  }
}
