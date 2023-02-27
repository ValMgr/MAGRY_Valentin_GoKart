import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/create_session/create_session.dart';
import 'package:go_kart/sessions/list_sessions/list_sessions.dart';
import 'package:go_kart/sessions/list_sessions/views/sessions_list.dart';
import 'package:quickalert/quickalert.dart';
import 'package:session_repository/session_repository.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) => ListSessionsCubit(SessionRepository())..getSessionsList(),
          child: const SessionPageContent(),
        ),
      ),
    );
  }
}

class SessionPageContent extends StatelessWidget {
  const SessionPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListSessionsCubit, ListSessionsState>(
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
            title: 'Aucune session trouvée',
            text: "Vous n'avez pas encore enregistré de session",
          );
        }
      },
      builder: (context, state) {
        if (state.status == ListSessionsStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ListSessionsStatus.failure) {
          return const Center(
            child: Text('Une erreur est survenue !'),
          );
        }

        if (state.sessions.isEmpty && state.status == ListSessionsStatus.success) {
          return const Center(
            child: Text('Aucune session trouvée !'),
          );
        }

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<CreateSessionPage>(
                  builder: (context) => const CreateSessionPage(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          body: const SessionsList(),
        );
      },
    );
  }
}
