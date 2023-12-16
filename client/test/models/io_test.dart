import 'package:client/models/io.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IO', () {
    test('well-formed json', () {
      const id = 1000, value = 2500;
      final json = <String,dynamic> {
        'tx_index': id,
        'value': value,
      };
      final io = IO.fromJson(json);
      expect(io.id, id);
      expect(io.value, value.toDouble());
    });

    test('malformed json', () {
      const value = 2500;
      final json = <String,dynamic> {
        'value': value,
      };
      expect(() => IO.fromJson(json), throwsException);
    });
  });
}