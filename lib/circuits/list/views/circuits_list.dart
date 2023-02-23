import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/circuits/circuits.dart';
import 'package:go_kart/circuits/list/views/circuit_information.dart';

class CircuitsList extends StatelessWidget {
  const CircuitsList({super.key});

  @override
  Widget build(BuildContext context) {
    final circuits = context.read<CircuitsCubit>().state.circuits;

    return ListView.builder(
      itemCount: circuits.length,
      itemBuilder: (context, index) {
        final circuit = circuits[index];
        return ListTile(
          leading: CountryFlags.flag(
            circuit.countryCode,
            height: 32,
            width: 32,
            borderRadius: 8,
          ),
          title: Text(circuit.name),
          subtitle: Text('${circuit.location} - ${circuit.country}'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute<CircuitInformations>(
              builder: (context) => CircuitInformations(circuit: circuit),
            ),
          ),
        );
      },
    );
  }
}
