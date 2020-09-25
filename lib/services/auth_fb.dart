import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFb {
  final _auth = FirebaseAuth.instance;

  Stream<User> get currentUser => _auth.authStateChanges();
  //sign in with credential
  Future signInWithCredential(AuthCredential credential) =>
      _auth.signInWithCredential(credential);
  Future<void> logout() => _auth.signOut();
}
