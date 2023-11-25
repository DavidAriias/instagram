import 'package:intl/intl.dart';

class HumanFormatHelper {
  static String humanReadbleNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);
  }

  static String timeFormatter(double milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds.toInt());
    int minutes = duration.inMinutes;
    int secondsLeft = (duration.inSeconds % 60).toInt();

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = secondsLeft.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
