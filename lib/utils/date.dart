import 'package:intl/intl.dart';

class DateUtils {
  static String toyMMMdString(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }

  static String toClockTime(DateTime date) {
    return DateFormat.jm().format(date);
  }

  static String toHoursAndMinutes(DateTime time) {
    DateFormat dateFormat;

    if (time.hour > 0 && time.minute > 0) {
      dateFormat = DateFormat("h 'hours' m 'minutes'");
    } else if (time.hour > 0) {
      dateFormat = DateFormat("h 'hours'");
    } else if (time.minute > 0) {
      dateFormat = DateFormat("m 'minutes'");
    } else {
      return 'No time budgeted';
    }
    return dateFormat.format(time);
  }

  static String eventToHoursAndMinutes(
      DateTime start, DateTime end, DateTime totalTime) {
    final hasHours = end.difference(start).inHours > 0;
    final hasMinutes = end.difference(start).inMinutes % 60 > 0;

    DateFormat dateFormat;
    if (hasHours && hasMinutes) {
      dateFormat = DateFormat("h 'hours' m 'minutes'");
    } else if (hasHours) {
      dateFormat = DateFormat("h 'hours'");
    } else {
      dateFormat = DateFormat("m 'minutes'");
    }

    return dateFormat.format(totalTime);
  }
}
