import 'package:intl/intl.dart';

class DateTimeUtils {
  static const _days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  static List<String> get days => _days;

  static String get currentMonth {
    DateTime now = DateTime.now();
    return DateFormat('MMM').format(now);
  }

  static String get currentDate {
    DateTime now = DateTime.now();
    return DateFormat('d').format(now);
  }

}
