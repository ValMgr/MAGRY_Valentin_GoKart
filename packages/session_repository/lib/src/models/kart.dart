// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Kart extends Equatable {
  final int? id;
  final String name;
  final int power;
  const Kart({
    this.id,
    required this.name,
    required this.power,
  });

  Kart copyWith({
    int? id,
    String? name,
    int? power,
  }) {
    return Kart(
      id: id ?? this.id,
      name: name ?? this.name,
      power: power ?? this.power,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'power': power,
    };
  }

  factory Kart.fromMap(Map<String, dynamic> map) {
    return Kart(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      power: map['power'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kart.fromJson(dynamic data) {
    return Kart.fromMap(data as Map<String, dynamic>);
  }

  static List<Kart> fromJsonList(List<dynamic> list) {
    if (list.isEmpty) return <Kart>[];
    return list.map(Kart.fromJson).toList();
  }

  static const empty = Kart(
    name: '',
    power: 0,
  );

  bool get isEmpty => this == empty;

  bool get isNotEmpty => this != empty;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, power];
}
