import 'package:session_repository/session_repository.dart';

class LapsUtils {
  static Lap getBestLap(List<Lap> laps) {
    return laps.fold(
      laps.first,
      (previousValue, element) => previousValue.duration < element.duration ? previousValue : element,
    );
  }
}
