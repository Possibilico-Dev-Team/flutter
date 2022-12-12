import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/screens/auth/signup/sign_up.dart';
import 'package:possibilico/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function? toggleView;
  const SignIn({super.key, this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
            const Text(
              'Login',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.only(top: 50.0)),
            //Image(image: AssetImage('PossibilicoLogo.png')),
            const Text('Email'),
            TextField(
              decoration: const InputDecoration(
                hintText: 'example@utrgv.edu',
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
                  minimumSize: const Size.fromHeight(50.0)),
              child: const Text('Sign In'),
              onPressed: () async {
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
              },
            ),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
            InkWell(
              child: const Text(
                "Don't have an account? Sign Up!",
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()))
              },
            ),
          ],
        ),
      ),
    );
  }
}
