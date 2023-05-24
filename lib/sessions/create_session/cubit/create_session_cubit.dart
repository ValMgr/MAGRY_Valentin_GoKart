import 'dart:math';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'create_session_state.dart';

class CreateSessionCubit extends Cubit<CreateSessionState> {
  CreateSessionCubit() : super(const CreateSessionState());

  final CircuitRepository _circuitRepository = CircuitRepository();
  final SessionRepository _sessionRepository = SessionRepository();
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  void addLap(Lap lap) {
    emit(state.copyWith(laps: [...state.laps, lap]));
  }

  void onFeelingChanged(String feeling) {
    emit(state.copyWith(feeling: feeling));
  }

  void onNoteChanged(int note) {
    emit(state.copyWith(note: note));
  }

  void onTrackStateChanged(String trackState) {
    emit(state.copyWith(trackState: trackState));
  }

  void onWeatherChanged(Map<String, dynamic> weather) {
    emit(state.copyWith(weather: weather));
  }

  void onCircuitChanged(Circuit circuit) {
    emit(state.copyWith(circuit: circuit));
  }

  void onKartChanged(Kart kart) {
    emit(state.copyWith(kart: kart));
  }

  Future<List<Circuit>> getCircuits() async {
    try {
      return _circuitRepository.getAllCircuits();
    } catch (e) {
      emit(state.copyWith(status: CreateSessionStatus.failure));
      return [];
    }
  }

  Future<List<Kart>> getKarts() async {
    return _sessionRepository.getKarts();
  }

  Future<void> createSession() async {
    try {
      emit(state.copyWith(status: CreateSessionStatus.submitting));
      final userId = _authenticationRepository.currentUser.id;

      final session = Session(
        date: DateTime.now().toUtc(),
        laps: state.laps,
        circuit: state.circuit,
        kart: state.kart,
        note: state.note,
        weather: state.weather,
        feeling: state.feeling,
        trackState: state.trackState,
        userId: userId,
      );

      final newSession = await _sessionRepository.createSession(session);
      emit(state.copyWith(status: CreateSessionStatus.created, created: newSession));
    } catch (e) {
      emit(state.copyWith(status: CreateSessionStatus.failure));
    }
  }

  void dismissError() {
    emit(state.copyWith(status: CreateSessionStatus.initial));
  }
}
