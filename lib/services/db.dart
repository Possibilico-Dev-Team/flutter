import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  /* access to instance */
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

// ***************** GET FIRESTORE DATA ********************
  /* return document reference */
  DocumentReference getDocRef(String collection, String document) {
    return _instance.collection(collection).doc(document);
  }

  /* return collection reference */

// ***************** GET FIRESTORE DATA ********************
  /* return document as Map */
  Future getDoc(String collection, String document) async {
    try {
      final doc = await _instance.collection(collection).doc(document).get();
      return (doc.data() != null ? doc.data() as Map<String, dynamic> : null);
    } catch (e) {
      return e.toString();
    }
  }

  /* return collection as List */
  Future getCollection(String collection) async {
    try {
      final coll = await _instance.collection(collection).get();
      List<Map<String, dynamic>> collDocs =
          coll.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return data;
      }).toList();
      print('db service getColl: $collDocs');
      return collDocs;
    } catch (e) {
      return e.toString();
    }
  }

// ***************** SET FIRESTORE DATA ********************
  /* set new value to doc */
  Future setDoc(
      String collection, String document, Map<String, dynamic> newValue,
      [bool autoID = false]) async {
    try {
      if (autoID) {
        final result = await _instance.collection(collection).add(newValue);
        print('db service setDoc: $result');
      } else {
        _instance
            .collection(collection)
            .doc(document)
            .set(newValue, SetOptions(merge: true));
        print('db service setDoc: set with autoID');
      }
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  /* add doc to collection */
  Future addDoc(
      String collection, String newDocument, Map<String, dynamic> value,
      [bool autoID = false]) async {
    return setDoc(collection, newDocument, value, autoID);
  }

  /* update doc value */
  Future updateDoc(
      String collection, String document, Map<String, dynamic> value) async {
    try {
      _instance.collection(collection).doc(document).update(value);
      print('db service updateDoc: did not fail');
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
