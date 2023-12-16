import 'package:intl/intl.dart';

final _currencyFormatter = NumberFormat.simpleCurrency(locale: "en_US");
String currencyString(double number) => _currencyFormatter.format(number);
