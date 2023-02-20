import 'package:profile_repository/src/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template profile_repository}
/// A repository that handles Profil related requests.
/// {@endtemplate}
class ProfileRepository {
  /// {@macro profile_repository}
  ProfileRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  /// Get current user profile
  // @TODO: to retrieve profile of other users
  // policy must be set to public in supabase
  Future<Profile> getOneProfile(String id) async {
    try {
      final data =
          await _supabaseClient.from('profile').select().eq('id', id).single();
      return Profile.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Update current user profile
  Future<void> updateProfile(Profile profile) async {
    try {
      await _supabaseClient
          .from('profile')
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      rethrow;
    }
  }
}
