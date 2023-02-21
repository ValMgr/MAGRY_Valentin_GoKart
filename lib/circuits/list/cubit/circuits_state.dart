part of 'circuits_cubit.dart';

class CircuitsListState extends Equatable {
  const CircuitsListState({
    this.circuits = const [],
  });

  final List<Circuit> circuits;

  @override
  List<Object?> get props => [circuits];
}
