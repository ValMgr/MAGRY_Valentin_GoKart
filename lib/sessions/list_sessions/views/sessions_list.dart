import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/list_sessions/cubit/list_sessions_cubit.dart';
import 'package:go_kart/sessions/single_session/single_session.dart';

class SessionsList extends StatelessWidget {
  SessionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final sessions = context.read<ListSessionsCubit>().state.sessions;

    return ListView.builder(
      itemCount: sessions.length,
      itemBuilder: (context, index) {
        final session = sessions[index];
        final timeSinceSession = getTimeSinceSession(session.date ?? DateTime.now());

        return ListTile(
          title: Text(session.circuit.name),
          subtitle: Text(
            'Laps: ${session.laps.length} - Il y a $timeSinceSession',
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute<SingleSessionView>(
                builder: (_) => BlocProvider.value(
                  value: context.read<ListSessionsCubit>(),
                  child: SingleSessionView(sessionId: session.id!),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

String getTimeSinceSession(DateTime date) {
  final now = DateTime.now();
  final difference = Duration(milliseconds: now.toUtc().millisecondsSinceEpoch - date.toUtc().millisecondsSinceEpoch);

  if (difference.inDays > 0) {
    return '${difference.inDays} jours';
  }

  if (difference.inHours > 0) {
    return '${difference.inHours} heures';
  }

  if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes';
  }

  return '${difference.inSeconds} secondes';
}
