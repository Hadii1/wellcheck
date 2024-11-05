import 'dart:async';

import 'package:wellcheck/models/user.dart';
import 'package:wellcheck/services/firebase_auth.dart';

class UserRepository {
  final FirebaseAuthService authService;

  UserRepository({
    required this.authService,
  });

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    return await authService.signIn(email: email, password: password);
  }

  Future<User?> register({
    required String email,
    required String password,
  }) async {
    return await authService.register(email: email, password: password);
  }

  Future<void> logOut() async {
    await authService.logout();
  }

  Future<User?> getUser() async {
    return await authService.getUser();
  }
}
