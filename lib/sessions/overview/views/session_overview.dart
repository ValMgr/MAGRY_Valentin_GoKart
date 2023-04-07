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
    return BlocBuilder<SessionOverviewCubit, SessionOverviewState>(builder: (context, state) {
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
                    getWeatherIcon(state.session.weather),
                    const Spacer(),
                    Text(formatDate(state.session.date)),
                    const Spacer(),
                    Text(state.session.circuit.name),
                  ],
                ),
                Row(
                  children: [
                    Text('Fastest lap: ${formatDuration(getBestLap(state.session.laps).duration)}'),
                    const Spacer(),
                    Text('Laps count: ${state.session.laps.length}')
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Icon getWeatherIcon(Map<String, dynamic> weather) {
    switch (weather['weather']) {
      case 'Clear':
        return const Icon(Icons.wb_sunny);
      case 'Clouds':
        return const Icon(Icons.cloud);
      case 'Rain':
        return const Icon(Icons.water_drop);
      case 'Snow':
        return const Icon(Icons.ac_unit);
      default:
        return const Icon(Icons.wb_sunny);
    }
  }

  String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  Lap getBestLap(List<Lap> laps) {
    return laps.fold(
      laps.first,
      (previousValue, element) => previousValue.duration < element.duration ? previousValue : element,
    );
  }

  String formatDuration(int duration) {
    final minutes = (duration / 60000).floor();
    final seconds = ((duration % 60000) / 1000).floor();
    final milliseconds = duration % 1000;
    return '$minutes:$seconds.$milliseconds';
  }
}
