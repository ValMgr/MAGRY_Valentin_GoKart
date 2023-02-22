// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

class Circuit extends Equatable {
  const Circuit({
    this.id,
    required this.name,
    required this.location,
    required this.address,
    required this.country,
    required this.countryCode,
    required this.lat,
    required this.lng,
    required this.length,
    required this.corners,
    required this.email,
    required this.telephone,
    required this.website,
  });

  /// Creates a new [Circuit] from a JSON object.
  factory Circuit.fromJson(dynamic data) {
    return Circuit(

      name: data['name'] as String,
      location: data['location'] as String,
      address: data['address'] as String,
      country: data['country'] as String,
      countryCode: data['country_code'] as String,
      lat: data['lat'] as double,
      lng: data['lng'] as double,
      length: data['length'] as int,
      corners: data['corners'] as int,
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
      'country_code': countryCode,
      'address': address,
      'lat': lat,
      'lng': lng,
      'length': length,
      'corners': corners,
      'email': email,
      'telephone': telephone,
      'website': website,
    };
  }

  final int? id;
  final String name;
  final String location;
  final String country;
  final String countryCode;
  final String address;
  final double lat;
  final double lng;
  final int length;
  final int corners;
  final String email;
  final String telephone;
  final String website;

  @override
  List<Object> get props => [
        name,
        location,
        address,
        country,
        countryCode,
        lat,
        lng,
        length,
        corners,
        email,
        telephone,
        website,
      ];
}
