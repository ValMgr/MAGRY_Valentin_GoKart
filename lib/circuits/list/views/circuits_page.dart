import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';

class CircuitsPage extends StatelessWidget {
  const CircuitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CircuitsCubit(CircuitRepository())..getCircuits(),
      child: const CircuitContent(),
    );
  }
}

class CircuitContent extends StatelessWidget {
  const CircuitContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CircuitsCubit, CircuitsListState>(
      builder: (context, state) {
        if (state.circuits.isEmpty) {
          return const Center(child: CircularProgressIndicator());
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
          body: const SafeArea(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircuitsList(),
            ),
          ),
        );
      },
    );
  }
}
