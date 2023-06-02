// ignore_for_file: inference_failure_on_function_invocation, avoid_dynamic_calls

import 'package:session_repository/session_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Session;

/// {@template profile_repository}
/// A repository that handles Profil related requests.
/// {@endtemplate}
class SessionRepository {
  /// {@macro profile_repository}
  SessionRepository({SupabaseClient? supabaseClient}) : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  /// Returns a list of [Session]s.
  Future<List<Session>?> getSessions() async {
    try {
      // get all sessions and laps related to them
      final data = await _supabaseClient
          .from('session')
          .select(
            '*, lap(*), kart(*), circuit(*)',
          )
          .eq('user_id', _supabaseClient.auth.currentUser!.id);
      return Session.fromJsonList(data as List);
    } catch (e) {
      rethrow;
    }
  }

  Future<Session> findOneSession(int id) async {
    try {
      final data = await _supabaseClient
          .from('session')
          .select(
            '*, lap(*), kart(*), circuit(*)',
          )
          .eq('id', id)
          .single();

      return Session.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new [Session].
  Future<Session> createSession(Session session) async {
    try {
      final body = session.toMap();
      final newSession =
          await _supabaseClient.from('session').insert(body).select('*, lap(*), kart(*), circuit(*)').single();

      final laps = await _supabaseClient
          .from('lap')
          .insert(session.laps.map((lap) => lap.copyWith(session: newSession['id'] as int).toMap()).toList())
          .select();

      final created = Session.fromJson(newSession).copyWith(laps: Lap.fromJsonList(laps as List));
      return created;
    } catch (e) {
      rethrow;
    }
  }

  /// Delete a [Session].
  Future<void> deleteSession(int id) async {
    try {
      await _supabaseClient.from('session').delete().eq('id', id);
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a list of [Kart]s
  /// Used to populate the dropdown menu
  // @TODO: move this to a kart repository
  // https://github.com/ValMgr/Go_Kart/issues/1
  Future<List<Kart>> getKarts() async {
    try {
      final data = await _supabaseClient.from('kart').select();
      return Kart.fromJsonList(data as List);
    } catch (e) {
      rethrow;
    }
  }
}
