part of 'create_session_cubit.dart';

class CreateSessionState extends Equatable {
  const CreateSessionState({
    this.step = 1,
    this.laps = const [],
    this.circuit = Circuit.empty,
    this.kart = Kart.empty,
    this.note = 0,
    this.weather = const {},
    this.feeling = '',
    this.trackState = '',
  });

  final int step;
  final List<Lap> laps;
  final Circuit circuit;
  final Kart kart;
  final int note;
  final Map<String, dynamic> weather;
  final String feeling;
  final String trackState;

  CreateSessionState copyWith({
    int? step,
    List<Lap>? laps,
    Circuit? circuit,
    Kart? kart,
    int? note,
    Map<String, dynamic>? weather,
    String? feeling,
    String? trackState,
  }) {
    return CreateSessionState(
      step: step ?? this.step,
      laps: laps ?? this.laps,
      circuit: circuit ?? this.circuit,
      kart: kart ?? this.kart,
      note: note ?? this.note,
      weather: weather ?? this.weather,
      feeling: feeling ?? this.feeling,
      trackState: trackState ?? this.trackState,
    );
  }

  @override
  List<Object> get props => [step, laps, circuit, kart, note, weather, feeling, trackState];
}
