import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_circuit_state.dart';

class CreateCircuitCubit extends Cubit<CreateCircuitState> {
  CreateCircuitCubit(this.circuitRepository)
      : super(const CreateCircuitState());

  final CircuitRepository circuitRepository;

  Future<bool> createCircuit() async {
    try {
      final circuit = Circuit(
        name: state.name,
        location: state.location,
        country: state.country,
        countryCode: state.countryCode,
        length: state.length,
        corners: state.corners,
        lat: state.lat,
        lng: state.lng,
        address: state.address,
        email: state.email,
        telephone: state.telephone,
        website: state.website,
      );

      await circuitRepository.createCircuit(circuit);
      return true;
    } catch (e) {
      emit(state.copyWith(failureMessage: e.toString()));
      return false;
    }
  }

  void nameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void locationChanged(String location) {
    emit(state.copyWith(location: location));
  }

  void countryChanged(String country) {
    emit(state.copyWith(country: country));
  }

  void countryCodeChanged(String countryCode) {
    emit(state.copyWith(countryCode: countryCode));
  }

  void lengthChanged(int length) {
    emit(state.copyWith(length: length));
  }

  void cornersChanged(int corners) {
    emit(state.copyWith(corners: corners));
  }

  void latChanged(double lat) {
    emit(state.copyWith(lat: lat));
  }

  void lngChanged(double lng) {
    emit(state.copyWith(lng: lng));
  }

  void addressChanged(String address) {
    emit(state.copyWith(address: address));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void telephoneChanged(String telephone) {
    emit(state.copyWith(telephone: telephone));
  }

  void websiteChanged(String website) {
    emit(state.copyWith(website: website));
  }

  void reset() {
    emit(const CreateCircuitState());
  }
}
