// ignore_for_file: comment_references

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_auth;

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  AuthenticationRepository({
    // CacheClient? cache,
    supabase_auth.Supabase? supabase,
  }) : supabase = supabase ?? supabase_auth.Supabase.instance;
  // _cache = cache ?? CacheClient();

  // final CacheClient _cache;

  /// The supabase instance
  final supabase_auth.Supabase supabase;

  /// User cache key.
  static const userCacheKey = '__user_cache_key__';

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return supabase.client.auth.onAuthStateChange.map((data) {
      return data.session != null ? data.session!.user.toUser : User.empty;
    });
  }

  /// Returns the current cached user.
  // User get currentProfil {
  //   return _cache.read<User>(key: userCacheKey) ?? User.empty;
  // }
  User get currentUser {
    return supabase.client.auth.currentSession != null
        ? supabase.client.auth.currentSession!.user.toUser
        : User.empty;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      final res = await supabase.client.auth.signUp(
        email: email,
        password: password,
      );
      await supabase.client
          .from('profile')
          .insert({'id': res.session!.user.id, 'email': email});
    } on supabase_auth.AuthException {
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
    } on supabase_auth.AuthException {
      rethrow;
    }
  }

  /// Checks if the user is an admin
  Future<bool> isUserAdmin(String userId) async {
    final admin = await supabase.client
        .from('admins')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    return admin != null;
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([supabase.client.auth.signOut()]);
    } on supabase_auth.AuthException {
      rethrow;
    }
  }
}

extension on supabase_auth.User {
  User get toUser {
    return User(id: id, email: email);
  }
}
