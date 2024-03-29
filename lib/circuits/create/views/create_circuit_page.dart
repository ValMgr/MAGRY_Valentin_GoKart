import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/theme/theme.dart';
import 'package:go_kart/circuits/circuits.dart';

class CreateCircuitPage extends StatelessWidget {
  const CreateCircuitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoKartAppBar.appBar('Create circuit'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocProvider(
            create: (_) => CreateCircuitCubit(CircuitRepository()),
            child: const CreateCircuitForm(),
          ),
        ),
      ),
    );
  }
}
