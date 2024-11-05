import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/models/user.dart';
import 'package:wellcheck/repositories/auth_repository.dart';
import 'package:wellcheck/services/firebase_auth.dart';
import 'package:wellcheck/services/local_storage.dart';
import 'package:wellcheck/shared/model/response.dart';

final userProvider = StateNotifierProvider<UserNotifier, Response<User?>>(
  (ref) => UserNotifier(
    // In a real scenario this can be injected using GetIt instead of initiating here
    UserRepository(
      authService: FirebaseAuthService(),
    ),
  ),
);

class UserNotifier extends StateNotifier<Response<User?>> {
  UserNotifier(this._repo)
      : super(
          Response.loading(),
        ) {
    init();
  }

  final UserRepository _repo;

  Future<void> init() async {
    await LocalStorage.init();

    try {
      final user = await _repo.getUser();
      state = Response.completed(user);
    } on Exception catch (_) {
      // In a real scenario we can capture the error here and
      // send it to a crash reporting service like sentry or crashlytics
      state = Response.completed(null);
    }
  }

  Future<void> logOut() async {
    await _repo.logOut();
    await LocalStorage().deleteHistory();
    state = Response.completed(null);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final user = await _repo.logIn(email: email, password: password);
    if (user != null) {
      state = Response.completed(user);
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final user = await _repo.register(email: email, password: password);
    if (user != null) {
      state = Response.completed(user);
    }
  }
}
