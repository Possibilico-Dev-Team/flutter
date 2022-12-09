import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:possibilico/models/possibilico_user.dart';
import 'package:possibilico/screens/wrapper.dart';
import 'package:possibilico/services/auth.dart';
import 'package:possibilico/services/db.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

/*
  _____                        _   _       _   _   _                
 |  __ \                      (_) | |     (_) | | (_)               
 | |__) |   ___    ___   ___   _  | |__    _  | |  _    ___    ___  
 |  ___/   / _ \  / __| / __| | | | '_ \  | | | | | |  / __|  / _ \ 
 | |      | (_) | \__ \ \__ \ | | | |_) | | | | | | | | (__  | (_) |
 |_|       \___/  |___/ |___/ |_| |_.__/  |_| |_| |_|  \___|  \___/ 
*/
// Donato Clemente, Joaquin Garcia, Hector Hinojosa, Miguel Ramirez

/*
 _____                     _           
|_   _|                   | |        _ 
  | |    ___   ______   __| |  ___  (_)
  | |   / _ \ |______| / _` | / _ \    
  | |  | (_) |        | (_| || (_) | _ 
  \_/   \___/          \__,_| \___/ (_)
*/

/*
______                      _    _
|  ___|                    | |  (_)                   
| |_    _   _  _ __    ___ | |_  _   ___   _ __   ___ 
|  _|  | | | || '_ \  / __|| __|| | / _ \ | '_ \ / __|
| |    | |_| || | | || (__ | |_ | || (_) || | | |\__ \
\_|     \__,_||_| |_| \___| \__||_| \___/ |_| |_||___/
*/

//Main function, will initialize to Firebase and then go into Homepage.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//Firebase Auth
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<PossibilicoUser?>.value(
      value: AuthService().user,
      initialData: AuthService().currentUser(),
      child: const MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
