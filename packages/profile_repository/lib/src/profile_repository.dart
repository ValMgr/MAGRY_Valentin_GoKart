import 'dart:io';

import 'package:profile_repository/src/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template profile_repository}
/// A repository that handles Profil related requests.
/// {@endtemplate}
class ProfileRepository {
  /// {@macro profile_repository}
  ProfileRepository({SupabaseClient? supabaseClient}) : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  /// Get current user profile
  Future<Profile> findOne(String id) async {
    try {
      final data = await _supabaseClient.from('profile').select().eq('id', id).single();
      return Profile.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadAvatar(File file) async {
    try {
      final extension = file.path.split('.').last;
      final fileName = '${_supabaseClient.auth.currentUser!.id}-avatar.$extension';

      await _supabaseClient.storage.from('avatars').remove([fileName]);
      await _supabaseClient.storage.from('avatars').upload(fileName, file);
      return _supabaseClient.storage.from('avatars').getPublicUrl(fileName);
    } catch (e) {
      throw Exception('Error uploading avatar: $e');
    }
  }

  /// Update current user profile
  Future<void> updateProfile(Profile profile) async {
    try {
      await _supabaseClient.from('profile').update(profile.toJson()).eq('id', profile.id);
    } catch (e) {
      rethrow;
    }
  }
}
