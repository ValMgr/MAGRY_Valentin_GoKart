import 'package:circuit_repository/circuit_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/circuits/list/list.dart';
import 'package:quickalert/quickalert.dart';

class CircuitInformations extends StatelessWidget {
  const CircuitInformations({super.key, required this.circuit});

  final Circuit circuit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoKartAppBar.appBar(circuit.name),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.warning,
            title: 'Delete circuit',
            text: 'Are you sure you want to delete this circuit ?',
            confirmBtnText: 'Yes',
            cancelBtnText: 'No',
            showCancelBtn: true,
            onConfirmBtnTap: () {
              context.read<CircuitsCubit>().deleteCircuit(circuit);
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop();
            },
          );
        },
        child: const Icon(Icons.delete_forever),
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
