import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthentication {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signOut() async {
    await _firebaseAuth.signOut();
  }

  //CurrentUser
  Future<User> getCurrentUser() async {
    User user = await _firebaseAuth.currentUser;
    print(user);
    return user;
  }

  Future<UserCredential> signIn(String email, String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user;
  }

  Future<UserCredential> register(String email, String password) async {
    var user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user;
  }
}
