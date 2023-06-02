import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/create_session/create_session.dart';
import 'package:go_kart/sessions/list_sessions/list_sessions.dart';
import 'package:go_kart/sessions/list_sessions/views/sessions_list.dart';
import 'package:quickalert/quickalert.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<CreateSessionPage>(
                  builder: (_) => BlocProvider.value(
                    value: context.read<ListSessionsCubit>(),
                    child: const CreateSessionPage(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: BlocConsumer<ListSessionsCubit, ListSessionsState>(
            listener: (context, state) {
              if (state.status == ListSessionsStatus.failure) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Oups !',
                  text: state.errorMessages,
                );
              }

              if (state.sessions.isEmpty && state.status == ListSessionsStatus.success) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.warning,
                  title: 'No sessions found !',
                  text: "You don't have any sessions yet.",
                );
              }
            },
            builder: (context, state) {
              if (state.status == ListSessionsStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.status == ListSessionsStatus.failure) {
                return const Center(
                  child: Text('An error occured !'),
                );
              }

              return SessionsList();
            },
          ),
        ),
        // ),
      ),
    );
  }
}
