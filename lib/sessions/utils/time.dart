class TimeUtils {
  static String formatDate(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${date.day}/${date.month}/${date.year}';
  }

  static String formatDuration(int duration) {
    final minutes = (duration / 60000).floor();
    final seconds = ((duration % 60000) / 1000).floor();
    final milliseconds = duration % 1000;
    return '$minutes:$seconds.$milliseconds';
  }
}
