import 'package:intl/intl.dart';

const _satoshiModifier = 100000000;
final _currencyFormatter = NumberFormat.currency(symbol: "₿", decimalDigits: 8, customPattern: "#,##0.00");
String currencyString(double number) => _currencyFormatter.format(number / _satoshiModifier);
