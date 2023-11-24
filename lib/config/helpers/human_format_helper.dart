import 'package:intl/intl.dart';

class HumanFormatHelper {
  static String humanReadbleNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
    ).format(number);
  }
}
