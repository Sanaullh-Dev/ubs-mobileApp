import 'package:intl/intl.dart';
import 'package:ubs/services/secure_storage.dart';
import 'package:ubs/utils/constants.dart';

String formatCurrency(num amount, {int decimalCount = 0}) {
  final formatCurrency =
      NumberFormat.simpleCurrency(decimalDigits: decimalCount);
  return formatCurrency.format(amount);
}

// Get path to Link convert
String getLink(String? path) {
  if (path != null && path != "") {
    var ck = path.substring(0, 4); // http
    if (ck == "http") {
      return path;
    }
    return "$API_URL/${path.replaceAll("\\", "/")}";
  }
  return "";
}

Future<String> getLoginId() async {
  final StorageService storageService = StorageService();
  var val = await storageService.readSecureData("LoginId");
  return val ?? "";
}
