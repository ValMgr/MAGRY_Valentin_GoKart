// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Lap extends Equatable {
  final int? id;
  final int? session;
  final int duration;

  const Lap({
    this.id,
    this.session,
    required this.duration,
  });

  Lap copyWith({
    int? id,
    int? session,
    int? duration,
  }) {
    return Lap(
      id: id ?? this.id,
      session: session ?? this.session,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'session_id': session,
      'duration': duration,
    };
  }

  factory Lap.fromMap(Map<String, dynamic> map) {
    return Lap(
      id: map['id'] != null ? map['id'] as int : null,
      session: map['session_id'] as int,
      duration: map['duration'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Lap.fromJson(dynamic data) => Lap.fromMap(data as Map<String, dynamic>);

  static List<Lap> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map(Lap.fromJson).toList();
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [duration];
}
