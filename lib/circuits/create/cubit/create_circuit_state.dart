part of 'create_circuit_cubit.dart';

class CreateCircuitState extends Equatable {
  const CreateCircuitState({
    this.name = '',
    this.location = '',
    this.country = '',
    this.countryCode = '',
    this.length = 0,
    this.corners = 0,
    this.lat = 0.0,
    this.lng = 0.0,
    this.address = '',
    this.email = '',
    this.telephone = '',
    this.website = '',
    this.failureMessage,
  });

  final String name;
  final String location;
  final String country;
  final String countryCode;
  final int length;
  final int corners;
  final double lat;
  final double lng;
  final String address;
  final String email;
  final String telephone;
  final String website;

  final String? failureMessage;

  CreateCircuitState copyWith({
    String? name,
    String? location,
    String? country,
    String? countryCode,
    int? length,
    int? corners,
    double? lat,
    double? lng,
    String? address,
    String? email,
    String? telephone,
    String? website,
    String? failureMessage,
  }) {
    return CreateCircuitState(
      name: name ?? this.name,
      location: location ?? this.location,
      country: country ?? this.country,
      countryCode: countryCode ?? this.countryCode,
      length: length ?? this.length,
      corners: corners ?? this.corners,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      address: address ?? this.address,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      website: website ?? this.website,
      failureMessage: failureMessage ?? this.failureMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        location,
        country,
        countryCode,
        length,
        corners,
        lat,
        lng,
        address,
        email,
        telephone,
        website,
        failureMessage,
      ];
}
