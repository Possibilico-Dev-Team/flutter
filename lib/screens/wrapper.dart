import 'package:flutter/material.dart';
import 'package:possibilico/screens/auth/authenticate.dart';
import 'package:possibilico/screens/auth/signup/onboarding.dart';
import 'package:possibilico/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return FutureBuilder(
          future: query('user/${user.uid}'),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occured while retrieving user data'),
              );
            } else {
              if (!snapshot.hasData) {
                return const OnBoard();
              }
              return const HomePage();
            }
          });
    }
  }
}

Future query(String query) async {
  try {
    DataSnapshot data = await database.ref(query).get();
    return data;
  } catch (e) {
    return e.toString();
  }
}
