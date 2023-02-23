// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class Session extends Equatable {
  const Session({
    this.id,
    required this.date,
    required this.circuit,
    required this.duration,
    required this.time,
    required this.feeling,
    required this.notes,
    required this.trackState,
    required this.weather,
    required this.temperature,
  });

  factory Session.fromJson(dynamic data) {
    return Session(
      id: data['id'] as int,
      date: DateTime.parse(data['date'] as String? ?? ''),
      circuit: data['circuit'] as int,
      duration: data['duration'] as String,
      time: data['time'] as String,
      feeling: data['feeling'] as String,
      notes: data['notes'] as int,
      trackState: data['trackState'] as String,
      weather: data['weather'] as String,
      temperature: data['temperature'] as double,
    );
  }

  /// Converts a [Session] instance to the JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'circuit': circuit,
      'duration': duration,
      'time': time,
      'feeling': feeling,
      'notes': notes,
      'trackState': trackState,
      'weather': weather,
      'temperature': temperature,
    };
  }

  /// Creates a list of [Session]s from a decoded JSON object list.
  static List<Session> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map(Session.fromJson).toList();
  }

  final int? id;
  final DateTime date;
  final int circuit;
  final String duration;
  final String time;
  final String feeling;
  final int notes;
  final String trackState;
  final String weather;
  final double temperature;

  /// Creates a copy of the [Session] with the given fields replaced with the
  Session copyWith({
    int? id,
    DateTime? date,
    int? circuit,
    String? duration,
    String? time,
    String? feeling,
    int? notes,
    String? trackState,
    String? weather,
    double? temperature,
  }) {
    return Session(
      id: id ?? this.id,
      date: date ?? this.date,
      circuit: circuit ?? this.circuit,
      duration: duration ?? this.duration,
      time: time ?? this.time,
      feeling: feeling ?? this.feeling,
      notes: notes ?? this.notes,
      trackState: trackState ?? this.trackState,
      weather: weather ?? this.weather,
      temperature: temperature ?? this.temperature,
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        circuit,
        duration,
        time,
        feeling,
        notes,
        trackState,
        weather,
        temperature,
      ];
}
