// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, avoid_dynamic_calls

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Circuit extends Equatable {
  const Circuit({
    this.id,
    this.createdAt,
    this.createdBy,
    required this.name,
    required this.location,
    required this.country,
    required this.countryCode,
    required this.address,
    required this.lat,
    required this.lng,
    required this.length,
    required this.corners,
    required this.email,
    required this.telephone,
    required this.website,
  });

  final int? id;
  final String? createdAt;
  final String? createdBy;
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

  Circuit copyWith({
    int? id,
    String? createdAt,
    String? createdBy,
    String? name,
    String? location,
    String? country,
    String? countryCode,
    String? address,
    double? lat,
    double? lng,
    int? length,
    int? corners,
    String? email,
    String? telephone,
    String? website,
  }) {
    return Circuit(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      name: name ?? this.name,
      location: location ?? this.location,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      address: address ?? this.address,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      length: length ?? this.length,
      corners: corners ?? this.corners,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      website: website ?? this.website,
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      location,
      country,
      countryCode,
      address,
      lat,
      lng,
      length,
      corners,
      email,
      telephone,
      website,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created_at': createdAt,
      'created_by': createdBy,
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

  factory Circuit.fromMap(Map<String, dynamic> map) {
    return Circuit(
      id: map['id'] != null ? map['id'] as int : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      createdBy: map['createdBy'] != null ? map['createdBy'] as String : null,
      name: map['name'] as String,
      location: map['location'] as String,
      country: map['country'] as String,
      countryCode: map['country_code'] as String,
      address: map['address'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      length: map['length'] as int,
      corners: map['corners'] as int,
      email: map['email'] as String,
      telephone: map['telephone'] as String,
      website: map['website'] as String,
    );
  }

  factory Circuit.fromJson(dynamic data) => Circuit.fromMap(data as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  static List<Circuit> fromJsonList(List<dynamic> list) {
    if (list.isEmpty) return [];
    return list.map(Circuit.fromJson).toList();
  }

  static const empty = Circuit(
    name: '',
    location: '',
    country: '',
    countryCode: '',
    address: '',
    lat: 0,
    lng: 0,
    length: 0,
    corners: 0,
    email: '',
    telephone: '',
    website: '',
  );

  bool get isEmpty => this == Circuit.empty;

  bool get isNotEmpty => this != Circuit.empty;

  @override
  bool get stringify => true;
}
