import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_kart/sessions/sessions.dart';
import 'package:session_repository/session_repository.dart';

class SessionOverview extends StatelessWidget {
  const SessionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionOverviewCubit, SessionOverviewState>(
      builder: (context, state) {
        if (state.status == SessionOverviewStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == SessionOverviewStatus.failure) {
          return const Center(
            child: Text('An error occured !'),
          );
        }

        if (state.status == SessionOverviewStatus.success && state.session == Session.empty) {
          return const Center(
            child: Text('No sessions found !'),
          );
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
                      Flexible(
                        child: Text(state.session.circuit.name),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (state.session.laps.isNotEmpty)
                        Text(
                          'Fastest lap: ${TimeUtils.formatDuration(LapsUtils.getBestLap(state.session.laps).duration)}',
                        )
                      else
                        const Text('Fastest lap: NT'),
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
