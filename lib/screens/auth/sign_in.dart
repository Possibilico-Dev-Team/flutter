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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        title: const Text('Sign In'),
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
              child: const Text('Sign In'),
              onPressed: () async {
                dynamic result = await _auth.signInWithEmail(
                    emailController.text, passwordController.text);
                if (result is String) {
                  setState(() {
                    passwordError = result;
                  });
                } else if (result is User) {
                  print('Signed In!');
                  print(result);
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
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
