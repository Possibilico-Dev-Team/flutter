import 'package:firebase_auth/firebase_auth.dart';
import 'package:possibilico/models/possibilico_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<PossibilicoUser?> get user {
    return _auth.userChanges().map<PossibilicoUser?>(
        ((User? user) => user != null ? PossibilicoUser(user) : null));
  }

  PossibilicoUser? currentUser() {
    return PossibilicoUser(
        _auth.currentUser != null ? _auth.currentUser as User : null);
  }

  // sign in with email & password
  Future signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.replaceAll(" ", ""), password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/wrong-password') {
        return "Incorrect Password";
      } else {
        print(e.message);
        return e.message;
      }
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  // register with email & password
  Future registerUserWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  // sign out
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
