import 'package:go_kart/sessions/sessions.dart';
import 'package:session_repository/session_repository.dart';

class LapData {
  LapData(this.index, this.duration, this.display);

  final int index;
  final int duration;
  final String display;
}

class LapsUtils {
  static Lap getBestLap(List<Lap> laps) {
    return laps.fold(
      laps.first,
      (previousValue, element) => previousValue.duration < element.duration ? previousValue : element,
    );
  }

  static List<int> toDurationList(List<Lap> laps) {
    return laps.map((e) => e.duration).toList();
  }

  static List<String> toFormattedDurationList(List<Lap> laps) {
    return laps.map((e) => TimeUtils.formatDuration(e.duration)).toList();
  }

  static List<LapData> toLapsData(List<Lap> laps) {
    return laps
        .asMap()
        .map((index, lap) => MapEntry(index, LapData(index, lap.duration, TimeUtils.formatDuration(lap.duration))))
        .values
        .toList();
  }
}
