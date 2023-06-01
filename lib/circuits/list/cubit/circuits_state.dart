part of 'circuits_cubit.dart';

enum CircuitsListStatus { initial, loading, success, failure }

class CircuitsListState extends Equatable {
  const CircuitsListState({
    this.circuits = const [],
    this.status = CircuitsListStatus.initial,
    this.errorMessages,
  });

  final List<Circuit> circuits;
  final CircuitsListStatus status;
  final String? errorMessages;

  CircuitsListState copyWith({
    List<Circuit>? circuits,
    CircuitsListStatus? status,
    String? errorMessages,
  }) {
    return CircuitsListState(
      circuits: circuits ?? this.circuits,
      status: status ?? this.status,
      errorMessages: errorMessages,
    );
  }

  @override
  List<Object?> get props => [circuits, status, errorMessages];
}
