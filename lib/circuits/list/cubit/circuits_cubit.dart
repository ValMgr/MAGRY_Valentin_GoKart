import 'package:circuit_repository/circuit_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'circuits_state.dart';

class CircuitsCubit extends Cubit<CircuitsListState> {
  CircuitsCubit() : super(const CircuitsListState());

  final CircuitRepository _circuitRepository = CircuitRepository();

  // @TODO - Update list when navigator pop
  // from circuit detail page or circuit create page
  Future<void> getCircuits() async {
    emit(const CircuitsListState(status: CircuitsListStatus.loading));
    try {
      final circuits = await _circuitRepository.getAllCircuits();

      if (circuits.isEmpty) {
        emit(const CircuitsListState());
        return;
      }

      emit(
        CircuitsListState(
          circuits: circuits,
          status: CircuitsListStatus.success,
        ),
      );
    } on Exception catch (error) {
      emit(
        CircuitsListState(
          errorMessages: error.toString(),
          status: CircuitsListStatus.failure,
        ),
      );
    }
  }

  Future<void> addCircuitToList(Circuit circuit) async {
    emit(
      CircuitsListState(
        circuits: List<Circuit>.from(state.circuits)..add(circuit),
      ),
    );
  }
}
