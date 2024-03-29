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
        child: BlocConsumer<CircuitsCubit, CircuitsListState>(
          listener: (context, state) {
            if (state.status == CircuitsListStatus.failure) {
              QuickAlert.show(
                context: context,
                title: 'Error',
                text: state.errorMessages,
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
                    builder: (_) => BlocProvider.value(
                      value: context.read<CircuitsCubit>(),
                      child: const CreateCircuitPage(),
                    ),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
              body: CircuitsList(),
            );
          },
        ),
      ),
    );
  }
}
