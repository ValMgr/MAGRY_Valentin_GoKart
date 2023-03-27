import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:session_repository/session_repository.dart';

part 'create_session_state.dart';

class CreateSessionCubit extends Cubit<CreateSessionState> {
  CreateSessionCubit() : super(const CreateSessionState());

  final CircuitRepository _circuitRepository = CircuitRepository();
  final SessionRepository _sessionRepository = SessionRepository();

  void addLap(Lap lap) {
    emit(state.copyWith(laps: [...state.laps, lap]));
  }

  void changeStep(int step) {
    emit(state.copyWith(step: step));
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
    return _circuitRepository.getAllCircuits();
  }

  Future<List<Kart>> getKarts() async {
    return _sessionRepository.getKarts();
  }
}
