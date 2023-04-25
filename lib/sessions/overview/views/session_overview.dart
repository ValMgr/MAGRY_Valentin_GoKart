import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/sessions.dart';
import 'package:session_repository/session_repository.dart';

class SessionOverview extends StatelessWidget {
  const SessionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SessionOverviewCubit()..getLastSession(),
      child: const SessionOverviewContent(),
    );
  }
}

class SessionOverviewContent extends StatelessWidget {
  const SessionOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionOverviewCubit, SessionOverviewState>(
      builder: (context, state) {
        if (state.session == Session.empty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Last session'),
                  Row(
                    children: [
                      WeatherUtils.getWeatherIcon(state.session.weather),
                      const Spacer(),
                      Text(TimeUtils.formatDate(state.session.date)),
                      const Spacer(),
                      Text(state.session.circuit.name),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          'Fastest lap: ${TimeUtils.formatDuration(LapsUtils.getBestLap(state.session.laps).duration)}'),
                      const Spacer(),
                      Text('Laps count: ${state.session.laps.length}')
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
