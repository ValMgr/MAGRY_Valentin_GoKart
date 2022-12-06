import 'package:go_kart/app/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@Injectable(as: AuthRepository)
class SupabaseAuthRepository implements AuthRepository {
  const SupabaseAuthRepository(this._supabase);
  final Supabase _supabase;

  @override
  Future<String> signInEmailAndPassword(String email, String password) async {
    final res = await _supabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final userId = res.user?.id;
    if (userId == null) {
      throw Exception('Failed to sign in');
    }

    return userId;
  }

  @override
  Future<String> signUpEmailAndPassword(String email, String password) async {
    final res = await _supabase.client.auth.signUp(
      email: email,
      password: password,
    );

    final userId = res.user?.id;
    if (userId == null) {
      throw Exception('Failed to sign up');
    }

    return userId;
  }

  @override
  Future<void> signOut() async {
    await _supabase.client.auth.signOut();
    return;
  }
}
