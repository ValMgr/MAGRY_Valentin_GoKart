class TimeUtils {
  static String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDuration(int duration) {
    final minutes = (duration / 1000 / 60).floor();
    final seconds = ((duration / 1000) % 60).floor();
    final milliseconds = duration % 1000;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${milliseconds.toString().padLeft(3, '0')}';
  }
}
