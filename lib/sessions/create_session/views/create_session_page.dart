import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/app/app.dart';
import 'package:go_kart/sessions/sessions.dart';
import 'package:quickalert/quickalert.dart';

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
    return BlocConsumer<CreateSessionCubit, CreateSessionState>(
      bloc: cubit,
      listener: (context, state) {
        if (state.status == CreateSessionStatus.failure) {
          QuickAlert.show(
            context: context,
            title: 'Oups !',
            text: 'Could not create session',
            type: QuickAlertType.error,
            onConfirmBtnTap: () {
              context.read<CreateSessionCubit>().dismissError();
              Navigator.of(context, rootNavigator: true).pop();
            },
          );
        }

        if (state.status == CreateSessionStatus.created && state.created != null) {
          context.read<ListSessionsCubit>().addSessionToList(state.created!);
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: GoKartAppBar.appBar("It's light out and away we go!"),
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
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          indicatorColor: Colors.black,
                          tabs: [Tab(text: 'Laps'), Tab(text: 'Details')],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              FirstStepView(
                                state: state,
                              ),
                              SecondStepView(
                                state: state,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _createSession(context, state),
                  style: GoKartButtons.elevatedButton,
                  child: const Text('Create session'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _createSession(BuildContext context, CreateSessionState state) {
    if (state.weather.isEmpty ||
        state.feeling.isEmpty ||
        state.laps.isEmpty ||
        state.note == -1 ||
        state.circuit.isEmpty ||
        state.kart.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Create session',
        text: "You haven't filled all the fields yet, are you sure you want to create the session ?",
        confirmBtnText: 'Yes',
        cancelBtnText: 'No',
        showCancelBtn: true,
        onConfirmBtnTap: () {
          context.read<CreateSessionCubit>().createSession();
          Navigator.of(context, rootNavigator: true).pop();
        },
      );
    } else {
      context.read<CreateSessionCubit>().createSession();
    }
  }
}

class FirstStepView extends StatelessWidget {
  const FirstStepView({
    super.key,
    required this.state,
    //required this.changeStep,
  });

  final CreateSessionState state;
  // final void Function(int) changeStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
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
  const SecondStepView({
    super.key,
    required this.state,
    // required this.changeStep,
  });

  final CreateSessionState state;
  // final void Function(int) changeStep;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SessionDetailsForm(),
        ],
      ),
    );
  }
}
