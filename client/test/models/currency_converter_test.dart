import 'package:client/models/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('currencyString', () {
    test('formats correctly', () {
      const satoshiNumber = 100000000.0;
      expect(currencyString(satoshiNumber), "1.00000000");

      const intMax = 2147483647.0;
      expect(currencyString(intMax), "21.47483647");

      const intMin = -2147483647.0;
      expect(currencyString(intMin), "-21.47483647");

      const one = 1.0;
      expect(currencyString(one), "0.00000001");
    });
  });
}