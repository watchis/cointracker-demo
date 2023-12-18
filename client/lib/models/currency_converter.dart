import 'package:intl/intl.dart';

String currencyString(CurrencyType type, double number) {
  final crypto = _currencyInfo[type];
  final currencyFormatter = NumberFormat.currency(decimalDigits: crypto!.decimalDigits, customPattern: "#,##0.00");
  return '${currencyFormatter.format(number / crypto.modifier)} ${crypto.abbreviation}';
}


enum CurrencyType {
  satoshi,
  bitcoin,
}

const _currencyInfo = <CurrencyType, _Cryptocurrency> {
  CurrencyType.satoshi: _Cryptocurrency("Sats", 1, 0),
  CurrencyType.bitcoin: _Cryptocurrency("BTC", 100000000, 8), // Satoshi modifier
};

class _Cryptocurrency {
  final String abbreviation;
  final double modifier;
  final int decimalDigits;

  const _Cryptocurrency(this.abbreviation, this.modifier, this.decimalDigits);
}
