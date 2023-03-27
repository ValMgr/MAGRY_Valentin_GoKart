import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/sessions.dart';
import 'package:session_repository/session_repository.dart';

class SessionDetailsForm extends StatelessWidget {
  const SessionDetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateSessionCubit>();

    return FutureBuilder(
      future: Future.wait([cubit.getCircuits(), cubit.getKarts()]),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final circuitsList = snapshot.data![0] as List<Circuit>;
        final kartsList = snapshot.data![1] as List<Kart>;

        return Column(
          children: [
            DropdownButton(
              value: cubit.state.circuit.isNotEmpty ? cubit.state.circuit.name : circuitsList.first.name,
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              items: circuitsList.map((circuit) {
                return DropdownMenuItem(
                  value: circuit.name,
                  child: Text(circuit.name),
                );
              }).toList(),
              onChanged: (value) {
                cubit.onCircuitChanged(circuitsList.firstWhere((circuit) => circuit.name == value));
              },
            ),
            DropdownButton(
              value: cubit.state.kart.isNotEmpty ? cubit.state.kart.name : kartsList.first.name,
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              items: kartsList.map((kart) {
                return DropdownMenuItem(
                  value: kart.name,
                  child: Text(kart.name),
                );
              }).toList(),
              onChanged: (value) {
                cubit.onKartChanged(kartsList.firstWhere((kart) => kart.name == value));
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Feeling',
              ),
              onChanged: cubit.onFeelingChanged,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Notes',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => cubit.onNoteChanged(int.tryParse(value) ?? 0),
            ),
          ],
        );
      },
    );
  }
}
