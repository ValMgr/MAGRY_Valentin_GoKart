import 'dart:async';

import 'package:authentication_repository/src/models/models.dart';
import 'package:cache/cache.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    CacheClient? cache,
    Supabase? supabase,
  })  : _cache = cache ?? CacheClient(),
        supabase = supabase ?? Supabase.instance;

  final CacheClient _cache;

  /// The supabase instance
  final Supabase supabase;

  /// Profil cache key.
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [Profil] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [Profil.empty] if the user is not authenticated.
  Stream<Profil> get user {
    return supabase.client.auth.onAuthStateChange.map((data) {
      final user = data.session != null
          ? Profil(id: data.session!.user.id)
          : Profil.empty;
      // @TODO - Cache not working
      // _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [Profil.empty] if there is no cached user.
  // @TODO - Cache not working
  // Profil get currentProfil {
  //   return _cache.read<Profil>(key: userCacheKey) ?? Profil.empty;
  // }

  Profil get currentProfil {
    return supabase.client.auth.currentUser != null
        ? Profil(
            id: supabase.client.auth.currentUser!.id,
            email: supabase.client.auth.currentUser!.email,
          )
        : Profil.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await supabase.client.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException {
      rethrow;
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException {
      rethrow;
    }
  }

  /// Signs out the current user which will emit
  /// [Profil.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([supabase.client.auth.signOut()]);
    } on AuthException {
      rethrow;
    }
  }
}

// I want to die
// extension on supabase_flutter Profil {
//   Profil get toProfil {
//     return Profil(id: id, name: name, email: email)
//   }
// }
