// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'dart:convert';

import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:session_repository/session_repository.dart';

class Session extends Equatable {
  const Session({
    this.id,
    required this.date,
    required this.circuit,
    required this.feeling,
    required this.notes,
    required this.trackState,
    required this.weather,
    required this.kart,
    required this.laps,
    required this.userId,
  });

  final int? id;
  final DateTime date;
  final Circuit circuit;
  final String feeling;
  final int notes;
  final String trackState;
  final Map<String, dynamic> weather;
  final Kart kart;
  final List<Lap> laps;
  final String userId;

  Session copyWith({
    int? id,
    DateTime? date,
    Circuit? circuit,
    String? feeling,
    int? notes,
    String? trackState,
    Map<String, dynamic>? weather,
    Kart? kart,
    List<Lap>? laps,
    String? userId,
  }) {
    return Session(
      id: id ?? this.id,
      date: date ?? this.date,
      circuit: circuit ?? this.circuit,
      feeling: feeling ?? this.feeling,
      notes: notes ?? this.notes,
      trackState: trackState ?? this.trackState,
      weather: weather ?? this.weather,
      kart: kart ?? this.kart,
      laps: laps ?? this.laps,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'circuit': circuit,
      'feeling': feeling,
      'notes': notes,
      'trackState': trackState,
      'weather': weather,
      'kart': kart.toMap(),
      'lap': laps.map((x) => x.toMap()).toList(),
      'userId': userId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] != null ? map['id'] as int : null,
      date: DateTime.parse(map['date'] as String),
      circuit: Circuit.fromMap(map['circuit'] as Map<String, dynamic>),
      feeling: map['feeling'] as String,
      notes: map['notes'] as int,
      trackState: map['trackstate'] as String,
      weather: map['weather'] as Map<String, dynamic>,
      kart: Kart.fromMap(map['kart'] as Map<String, dynamic>),
      laps: Lap.fromJsonList(map['lap'] as List<dynamic>),
      userId: map['user_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(dynamic data) {
    return Session.fromMap(data as Map<String, dynamic>);
  }

  static List<Session> fromJsonList(List<dynamic> list) {
    if (list.isEmpty) return [];
    return list.map(Session.fromJson).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      date,
      circuit,
      feeling,
      notes,
      trackState,
      weather,
      kart,
      laps,
      userId,
    ];
  }
}
