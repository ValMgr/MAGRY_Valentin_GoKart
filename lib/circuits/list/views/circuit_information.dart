import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_kart/app/app.dart';

class CircuitInformations extends StatelessWidget {
  const CircuitInformations({super.key, required this.circuit});

  final Circuit circuit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoKartAppBar.appBar(circuit.name),
      floatingActionButton: FloatingActionButton(
        // @TODO - Update circuit informations
        onPressed: () => print('edit circuit'),
        child: const Icon(Icons.edit),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                'Informations',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              Text('Virages: ${circuit.corners}'),
              Text('Piste: ${circuit.length}m'),
              const Divider(),
              Text('Contact', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Text('Email: ${circuit.email}'),
              Text('Téléphone: ${circuit.telephone}'),
              Text('Site web: ${circuit.website}'),
              const Divider(),
              Text('Adresse', style: Theme.of(context).textTheme.headline6),
              const SizedBox(height: 8),
              Text('${circuit.location}, ${circuit.address}'),
            ],
          ),
        ),
      ),
    );
  }
}
