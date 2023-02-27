import 'package:session_repository/session_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Session;

/// {@template profile_repository}
/// A repository that handles Profil related requests.
/// {@endtemplate}
class SessionRepository {
  /// {@macro profile_repository}
  SessionRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  /// Returns a list of [Session]s.
  Future<List<Session>?> getSessions() async {
    try {
      // get all sessions and laps related to them
      final data = await _supabaseClient.from('session').select(
            '*, lap(*), kart(*), circuit(*)',
          );
      print(data);
      return Session.fromJsonList(data as List);
    } catch (e) {
      rethrow;
    }
  }
}
