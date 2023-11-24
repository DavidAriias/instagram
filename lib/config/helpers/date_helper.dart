import 'package:intl/intl.dart';

class DateHelper {
  static String formatDate(DateTime date) {
    return DateFormat('d MMMM y', 'en_US').format(date);
  }

  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      return (age - 1);
    }
    return age;
  }

  static String formatPostDate(DateTime postDate) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(postDate);

    if (difference.inDays > 6) {
      // If the difference is more than a week, display the date in "MMMM d, y" format
      return DateFormat('MMMM d, y').format(postDate);
    } else if (difference.inDays > 0) {
      // If the difference is more than a day, display the time in "d days ago" format
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      // If the difference is more than an hour, display the time in "h hours ago" format
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      // If the difference is more than a minute, display the time in "m mins ago" format
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'min' : 'mins'} ago';
    } else {
      // If the difference is less than or equal to a minute, display a custom message
      return 'A moment ago';
    }
  }
}
