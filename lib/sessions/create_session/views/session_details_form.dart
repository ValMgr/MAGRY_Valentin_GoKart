import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/extensions/string.dart';
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
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Circuit',
              ),
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
            DropdownButtonFormField(
              decoration: const InputDecoration(
                labelText: 'Kart',
              ),
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Feeling',
              ),
              onChanged: cubit.onFeelingChanged,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Trackstate',
              ),
              onChanged: cubit.onTrackStateChanged,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Note',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => cubit.onNoteChanged(int.tryParse(value) ?? 0),
            ),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'Weather',
                      ),
                      icon: const Icon(Icons.arrow_downward),
                      items: Weather.values.map((weather) {
                        return DropdownMenuItem(
                          value: weather.name.capitalize(),
                          child: SizedBox(
                            child: Text(
                              weather.name.capitalize(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) => cubit.onWeatherChanged({...cubit.state.weather, 'weather': value}),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Temperature',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          cubit.onWeatherChanged({...cubit.state.weather, 'temperature': int.tryParse(value) ?? 0}),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
