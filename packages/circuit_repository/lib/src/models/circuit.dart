// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class Circuit extends Equatable {
  const Circuit({
    required this.id,
    required this.name,
    required this.location,
    required this.country,
    required this.lat,
    required this.lng,
    required this.length,
    required this.turns,
    required this.email,
    required this.telephone,
    required this.website,
  });

  /// Creates a new [Circuit] from a JSON object.
  factory Circuit.fromJson(dynamic data) {
    return Circuit(
      id: data['id'] as int,
      name: data['name'] as String,
      location: data['location'] as String,
      country: data['country'] as String,
      lat: data['lat'] as double,
      lng: data['lng'] as double,
      length: data['length'] as int,
      turns: data['turns'] as int,
      email: data['email'] as String,
      telephone: data['telephone'] as String,
      website: data['website'] as String,
    );
  }

  /// Creates a list of [Circuit]s from a decoded JSON object list.
  static List<Circuit> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((data) => Circuit.fromJson(data)).toList();
  }

  /// Converts a [Circuit] instance to the JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'country': country,
      'lat': lat,
      'lng': lng,
      'length': length,
      'turns': turns,
      'email': email,
      'telephone': telephone,
      'website': website,
    };
  }

  final int id;
  final String name;
  final String location;
  final String country;
  final double lat;
  final double lng;
  final int length;
  final int turns;
  final String email;
  final String telephone;
  final String website;

  @override
  List<Object> get props => [
        id,
        name,
        location,
        country,
        lat,
        lng,
        length,
        turns,
        email,
        telephone,
        website,
      ];
}
