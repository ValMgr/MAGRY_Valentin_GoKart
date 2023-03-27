import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';
import 'package:quickalert/quickalert.dart';

class CircuitsPage extends StatelessWidget {
  const CircuitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => CircuitsCubit(CircuitRepository())..getCircuits(),
          child: const CircuitContent(),
        ),
      ),
    );
  }
}

class CircuitContent extends StatelessWidget {
  const CircuitContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CircuitsCubit, CircuitsListState>(
      listener: (context, state) {
        if (state.status == CircuitsListStatus.failure) {
          QuickAlert.show(
            context: context,
            title: 'Error',
            text: state.errorMessages!,
            type: QuickAlertType.error,
          );
        }
      },
      builder: (context, state) {
        if (state.circuits.isEmpty && state.status == CircuitsListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == CircuitsListStatus.failure) {
          return const Center(child: Text('Une erreur est survenue !'));
        }

        if (state.circuits.isEmpty && state.status == CircuitsListStatus.success) {
          return const Center(child: Text('Aucun circuit trouvé !'));
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<CreateCircuitPage>(
                builder: (context) => const CreateCircuitPage(),
              ),
            ),
            child: const Icon(Icons.add),
          ),
          body: const CircuitsList(),
        );
      },
    );
  }
}
