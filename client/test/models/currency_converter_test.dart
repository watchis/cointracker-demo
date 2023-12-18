import 'package:client/models/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('currencyString', () {
    test('bitcoin formats correctly', () {
      const satoshiNumber = 100000000.0;
      expect(currencyString(CurrencyType.bitcoin, satoshiNumber), "1.00000000 BTC");

      const intMax = 2147483647.0;
      expect(currencyString(CurrencyType.bitcoin, intMax), "21.47483647 BTC");

      const intMin = -2147483647.0;
      expect(currencyString(CurrencyType.bitcoin, intMin), "-21.47483647 BTC");

      const one = 1.0;
      expect(currencyString(CurrencyType.bitcoin, one), "0.00000001 BTC");
    });
  });
}