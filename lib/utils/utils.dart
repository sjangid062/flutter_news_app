import 'package:intl/intl.dart';

class Utils {
  static formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm aa');

    return formatter.format(dateTime);
  }
}
