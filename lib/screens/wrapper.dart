import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:possibilico/models/possibilico_user.dart';
import 'package:possibilico/screens/auth/authenticate.dart';
import 'package:possibilico/screens/auth/onboarding/onboarding.dart';
import 'package:possibilico/screens/home/home.dart';
import 'package:possibilico/services/auth.dart';
import 'package:possibilico/services/db.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PossibilicoUser?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return StreamProvider<DocumentSnapshot?>.value(
        value: user.userData(),
        initialData: null,
        child: const OnboardToggler(),
      );
    }
  }
}

class OnboardToggler extends StatelessWidget {
  const OnboardToggler({super.key});

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot? userData = Provider.of<DocumentSnapshot?>(context);
    if (userData?.data() != null) {
      return const HomePage();
    } else {
      return const OnBoard();
    }
  }
}
