import 'package:flutter/material.dart';
import 'package:session_repository/session_repository.dart';

class LapsList extends StatelessWidget {
  const LapsList({super.key, required this.laps});

  final List<Lap> laps;

  @override
  Widget build(BuildContext context) {
    if (laps.isEmpty) {
      return const Text('No laps yet');
    }

    final bestLapDuration = laps.fold<int>(
      laps.first.duration,
      (previousValue, element) => previousValue < element.duration ? previousValue : element.duration,
    );

    return ListView.builder(
      itemCount: laps.length,
      itemBuilder: (context, index) {
        final duration = Duration(milliseconds: laps[index].duration);
        final minutes = duration.inMinutes.toString().padLeft(2, '0');
        final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
        final milliseconds = (duration.inMilliseconds % 1000).toString().padLeft(3, '0');
        final leading = index == 0
            ? const Icon(Icons.start)
            : laps[index].duration < laps[index - 1].duration
                ? const Icon(Icons.arrow_upward)
                : const Icon(Icons.arrow_downward);
        final iconColor = index == 0
            ? Colors.transparent
            : laps[index].duration < laps[index - 1].duration
                ? Colors.green
                : Colors.red;

        return ListTile(
          leading: leading,
          title: Text('$minutes:$seconds:$milliseconds'),
          iconColor: iconColor,
          textColor: laps[index].duration == bestLapDuration ? Colors.purple : null,
        );
      },
    );
  }
}
