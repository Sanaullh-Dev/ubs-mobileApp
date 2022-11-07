import 'package:intl/intl.dart';
import 'package:ubs/utils/constants.dart';

String formatCurrency(num amount, {int decimalCount = 0}) {
  final formatCurrency =
      NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);
}

  // Get path to Link convert 
  String getLink(String? path){
    if(path != null && path != ""){
    return "$API_URL/${path.replaceAll("\\", "/")}";
    }
    return "";
  }
