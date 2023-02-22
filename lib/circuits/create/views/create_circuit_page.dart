import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';

class CreateCircuitPage extends StatelessWidget {
  const CreateCircuitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create circuit'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) =>
                CreateCircuitCubit(context.read<CircuitRepository>()),
            child: const CreateCircuitForm(),
          ),
        ),
      ),
    );
  }
}
