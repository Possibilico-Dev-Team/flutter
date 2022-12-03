import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> userChanges() {
    return _auth.userChanges();
  }

  User? currentUser() {
    return _auth.currentUser;
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
        return e.message;
      }
    } catch (e) {
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
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // sign out
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
