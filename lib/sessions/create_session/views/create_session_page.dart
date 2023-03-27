import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/sessions.dart';

class CreateSessionPage extends StatelessWidget {
  const CreateSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateSessionCubit(),
      child: const CreateSessionView(),
    );
  }
}

class CreateSessionView extends StatelessWidget {
  const CreateSessionView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateSessionCubit>();
    return BlocBuilder<CreateSessionCubit, CreateSessionState>(
      bloc: cubit,
      builder: (context, state) {
        void changeStep(int step) => cubit.changeStep(step);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Light's out and away we go !"),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => AddLap(
                  cubit: cubit,
                ),
              );
            },
            child: const Icon(Icons.add_alarm_outlined),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: state.step - 1,
                    children: [
                      FirstStepView(
                        state: state,
                        changeStep: changeStep,
                      ),
                      SecondStepView(
                        state: state,
                        changeStep: changeStep,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => print('create session'),
                  child: const Text('Create session'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class FirstStepView extends StatelessWidget {
  const FirstStepView({super.key, required this.state, required this.changeStep});

  final CreateSessionState state;
  final void Function(int) changeStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => changeStep(2),
            child: Row(
              children: const [
                Text('Session details'),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: LapsList(
              laps: state.laps,
            ),
          ),
        ],
      ),
    );
  }
}

class SecondStepView extends StatelessWidget {
  const SecondStepView({super.key, required this.state, required this.changeStep});

  final CreateSessionState state;
  final void Function(int) changeStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => changeStep(1),
            child: Row(
              children: const [
                Icon(Icons.arrow_back),
                Text('Laps'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ignore: prefer_const_constructors
          SessionDetailsForm(),
        ],
      ),
    );
  }
}
