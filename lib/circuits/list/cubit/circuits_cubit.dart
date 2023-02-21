import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'circuits_state.dart';

class CircuitsCubit extends Cubit<CircuitsListState> {
  CircuitsCubit(this._circuitRepository) : super(const CircuitsListState());

  final CircuitRepository _circuitRepository;

  Future<void> getCircuits() async {
    try {
      final circuits = await _circuitRepository.getAllCircuits();

      if (circuits == null) {
        emit(const CircuitsListState());
        return;
      }

      emit(CircuitsListState(circuits: circuits));
    } on Exception catch (_) {
      emit(const CircuitsListState());
    }
  }
}
