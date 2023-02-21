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
            onPressed: () => context.read<CircuitsCubit>().getCircuits(),
            child: const Icon(Icons.add),
          ),
          body: ListView.builder(
            itemCount: state.circuits.length,
            itemBuilder: (context, index) {
              final circuit = state.circuits[index];
              return ListTile(
                title: Text(circuit.name),
                subtitle: Text(circuit.location),
              );
            },
          ),
        );
      },
    );
  }
}
