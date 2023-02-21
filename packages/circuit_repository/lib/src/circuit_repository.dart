import 'package:circuit_repository/src/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// {@template profile_repository}
/// A repository that handles Profil related requests.
/// {@endtemplate}
class CircuitRepository {
  /// {@macro profile_repository}
  CircuitRepository({SupabaseClient? supabaseClient})
      : _supabaseClient = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabaseClient;

  /// Returns a list of [Circuit]s.
  Future<List<Circuit>?> getAllCircuits() async {
    try {
      final jsonList = await _supabaseClient
          .from('circuit')
          .select()
          .order('name', ascending: true);

      return Circuit.fromJsonList(jsonList as List<dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Returns a list of [Circuit]s filtered by any [Circuit] property.
  Future<List<Circuit>?> getCircuitsByProperty(
      String property, String value) async {
    try {
      final circuits = await _supabaseClient
          .from('circuit')
          .select()
          .eq(property, value)
          .order('name', ascending: true);

      return Circuit.fromJsonList(circuits as List<dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Return a single [Circuit] by id.
  Future<Circuit?> getCircuitById(String id) async {
    try {
      final circuit =
          await _supabaseClient.from('circuit').select().eq('id', id).single();

      return Circuit.fromJson(circuit as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new [Circuit].
  Future<Circuit?> createCircuit(Circuit circuit) async {
    try {
      final newCircuit = await _supabaseClient
          .from('circuit')
          .insert(circuit.toJson())
          .single();
    } catch (e) {
      rethrow;
    }
  }

  /// Update an existing [Circuit].
  Future<Circuit?> updateCircuit(Circuit circuit) async {
    try {
      final updatedCircuit = await _supabaseClient
          .from('circuit')
          .update(circuit.toJson())
          .eq('id', circuit.id)
          .single();
    } catch (e) {
      rethrow;
    }
  }

  /// Delete an existing [Circuit].
  Future<Circuit?> deleteCircuit(Circuit circuit) async {
    try {
      final deletedCircuit = await _supabaseClient
          .from('circuit')
          .delete()
          .eq('id', circuit.id)
          .single();
    } catch (e) {
      rethrow;
    }
  }
}
