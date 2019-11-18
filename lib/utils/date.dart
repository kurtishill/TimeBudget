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
      String hours = 'hours';
      String minutes = 'minutes';
      if (time.hour == 1) {
        dateFormat = DateFormat("h 'hour' m 'minutes'");
      }
      if (time.minute == 1) {
        minutes = 'minute';
      }
      dateFormat = DateFormat("h '$hours' m '$minutes'");
    } else if (time.hour > 0) {
      if (time.hour == 1) {
        dateFormat = DateFormat("h 'hour'");
      } else {
        dateFormat = DateFormat("h 'hours'");
      }
    } else if (time.minute > 0) {
      if (time.minute == 1) {
        dateFormat = DateFormat("m 'minute'");
      } else {
        dateFormat = DateFormat("m 'minutes'");
      }
    } else {
      return 'No time budgeted';
    }
    return dateFormat.format(time);
  }

  static String eventToHoursAndMinutes(
      DateTime start, DateTime end, DateTime totalTime) {
    final hours = end.difference(start).inHours;
    final minutes = end.difference(start).inMinutes % 60;

    DateFormat dateFormat;
    if (hours > 0 && minutes > 0) {
      String hourText = 'hours';
      String minuteText = 'minutes';
      if (hours == 1) {
        hourText = 'hour';
      }
      if (minutes == 1) {
        minuteText = 'minute';
      }
      dateFormat = DateFormat("h '$hourText' m '$minuteText'");
    } else if (hours > 0) {
      if (hours == 1) {
        dateFormat = DateFormat("h 'hour'");
      } else {
        dateFormat = DateFormat("h 'hours'");
      }
    } else {
      if (minutes == 1) {
        dateFormat = DateFormat("m 'minute'");
      } else {
        dateFormat = DateFormat("m 'minutes'");
      }
    }

    return dateFormat.format(totalTime);
  }
}
