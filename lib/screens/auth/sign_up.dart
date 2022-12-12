import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/services/auth.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  const SignUp({super.key, required this.toggleView});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? passwordError;
  String? emailError;

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
              'Sign Up',
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
            const Spacer(flex: 2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50.0),
                  backgroundColor: const Color(0xFF5A6499)),
              child: const Text('Sign Up'),
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
                }
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            InkWell(
              child: const Text(
                "Already have an account? Log In!",
                style: TextStyle(color: Color(0xFF5A6499)),
              ),
              onTap: () => {widget.toggleView()},
            ),
          ],
        ),
      ),
    );
  }
}
