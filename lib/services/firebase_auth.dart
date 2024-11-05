import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellcheck/models/user.dart' as model;
import 'package:wellcheck/utils/exceptions.dart';

class FirebaseAuthService {
  Future<model.User?> getUser() async {
    final temp = FirebaseAuth.instance.currentUser;
    if (temp == null) return null;
    return model.User(
      id: temp.uid,
      username: temp.displayName,
      email: temp.email,
    );
  }

  Future<model.User?> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) throw AuthenticationError();
    return model.User(
      id: credential.user!.uid,
      username: credential.user!.displayName,
      email: credential.user!.email,
    );
  }

  Future<model.User?> register({
    required String email,
    required String password,
  }) async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user == null) throw AuthenticationError();

    return model.User(
      id: credential.user!.uid,
      username: credential.user!.displayName,
      email: credential.user!.email,
    );
  }

  Future<void> logout() => FirebaseAuth.instance.signOut();
}
