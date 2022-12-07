import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:possibilico/services/db.dart';

class PossibilicoUser {
  User? _userFirebase;
  Map<String, dynamic>? _properties;
  String? _id;

  PossibilicoUser(User user) {
    _userFirebase = user;
    _id = user.uid;
    initProps().then(
      (value) => _properties = value,
    );
  }

  Future initProps() async {
    final result =
        await DataService().getDoc('user', _userFirebase?.uid as String);
    if (result is Map<String, dynamic>) {
      print(result);
      return result;
    }
    return null;
  }

  Map<String, dynamic>? getProps() {
    return _properties;
  }

  User getUser() {
    return _userFirebase as User;
  }

  String id() {
    return _id as String;
  }

  void setProps(Map<String, dynamic>? newProps) {
    _properties = newProps;
  }

  void setUser(User? newUser) {
    _userFirebase = newUser;
  }

  Stream<DocumentSnapshot> userData() {
    DocumentReference ref = DataService().getDocRef('user', _id as String);
    return ref.snapshots();
  }
}
