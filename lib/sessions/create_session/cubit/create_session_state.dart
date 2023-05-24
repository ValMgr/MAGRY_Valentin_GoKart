part of 'create_session_cubit.dart';

enum CreateSessionStatus { initial, submitting, created, failure }

class CreateSessionState extends Equatable {
  const CreateSessionState({
    this.laps = const [],
    this.circuit = Circuit.empty,
    this.kart = Kart.empty,
    this.note = -1,
    this.weather = const {},
    this.feeling = '',
    this.trackState = '',
    this.status = CreateSessionStatus.initial,
    this.created,
  });

  final List<Lap> laps;
  final Circuit circuit;
  final Kart kart;
  final int note;
  final Map<String, dynamic> weather;
  final String feeling;
  final String trackState;
  final CreateSessionStatus status;
  final Session? created;

  CreateSessionState copyWith({
    List<Lap>? laps,
    Circuit? circuit,
    Kart? kart,
    int? note,
    Map<String, dynamic>? weather,
    String? feeling,
    String? trackState,
    CreateSessionStatus? status,
    Session? created,
  }) {
    return CreateSessionState(
      laps: laps ?? this.laps,
      circuit: circuit ?? this.circuit,
      kart: kart ?? this.kart,
      note: note ?? this.note,
      weather: weather ?? this.weather,
      feeling: feeling ?? this.feeling,
      trackState: trackState ?? this.trackState,
      status: status ?? this.status,
      created: created ?? this.created,
    );
  }

  @override
  List<Object?> get props => [
        laps,
        circuit,
        kart,
        note,
        weather,
        feeling,
        trackState,
        status,
        created,
      ];
}
