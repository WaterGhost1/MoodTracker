import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  static String getDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }

  static String getTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }
}
