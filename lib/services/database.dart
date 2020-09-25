import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference homeCollection =
      FirebaseFirestore.instance.collection('home');

  Future updateUserData(String sugars, String name) async {
    return await homeCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
    });
  }
}
