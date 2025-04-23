import 'package:intl/intl.dart';

class DateFormatter {
  static String getDate(DateTime dateTime) {
    return DateFormat('MMMM dd, yyyy').format(dateTime);
  }
}
