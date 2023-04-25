import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/list_sessions/cubit/list_sessions_cubit.dart';
import 'package:go_kart/sessions/single_session/single_session.dart';
import 'package:quickalert/quickalert.dart';
import 'package:session_repository/session_repository.dart';

class SingleSessionView extends StatelessWidget {
  const SingleSessionView({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SingleSessionCubit()..getSession(sessionId),
      child: SingleSesionContent(
        sessionId: sessionId,
      ),
    );
  }
}

class SingleSesionContent extends StatelessWidget {
  const SingleSesionContent({super.key, required this.sessionId});

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SingleSessionCubit, SingleSessionState>(
      listener: (context, state) {
        if (state.status == SingleSessionStatus.deleted) {
          context.read<ListSessionsCubit>().removeSession(state.session.id!);
        }

        if (state.status == SingleSessionStatus.failure) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Oups !',
            text: 'Something went wrong',
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Session details'),
          elevation: 4,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<SingleSessionCubit>().deleteSession();
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.delete_forever),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: BlocBuilder<SingleSessionCubit, SingleSessionState>(
                builder: (context, state) {
                  if (state.session == Session.empty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      Text(state.session.circuit.name),
                      Text(state.session.weather.toString()),
                      Text(state.session.date.toString()),
                      Text(state.session.laps.length.toString()),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
