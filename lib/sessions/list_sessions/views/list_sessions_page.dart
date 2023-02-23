import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/list_sessions/list_sessions.dart';
import 'package:session_repository/session_repository.dart';

class ListSessionPage extends StatelessWidget {
  const ListSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (_) =>
              ListSessionsCubit(SessionRepository())..getSessionsList(),
          child: const ListSessionsContent(),
        ),
      ),
    );
  }
}

class ListSessionsContent extends StatelessWidget {
  const ListSessionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Sessions list page'),
      ],
    );
  }
}
