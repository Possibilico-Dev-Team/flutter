import 'package:flutter/material.dart';
import 'package:possibilico/screens/auth/authenticate.dart';
import 'package:possibilico/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return Home();
    }
  }
}
