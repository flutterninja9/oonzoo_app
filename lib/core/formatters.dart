import 'package:intl/intl.dart';

class Formatter {
  static String formatCurrency(String number) {
    final oCcy = NumberFormat("#,##0.00");
    return oCcy.format(number);
  }

  static 
  num getDiscountedamount(num amt, double discount) {
    return amt - (amt * (discount * 100) / 100);
  }
}
