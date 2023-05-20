import 'package:firebase_auth/firebase_auth.dart';

enum AuthState {
  authenticated,
  unAuthenticated,
  unknown,
}

class AuthService {
  Future<void> loginWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthState> getSignedInState() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return AuthState.unAuthenticated;
    }
    return AuthState.authenticated;
  }

  Future<User?> getSignedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser;
  }
}
