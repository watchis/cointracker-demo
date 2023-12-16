import 'package:client/models/io.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction', () {
    group('fromJson', () {
      test('well-formed json', () {
        const hash = 'hashId', relayedBy = 'relayedBy';
        const inId = 100, inValue = 250;
        const outId = 500, outValue = 750;

        final json = <String, dynamic>{
          'hash': hash,
          'relayed_by': relayedBy,
          'inputs': [
            <String, dynamic>{
              'prev_out': <String, dynamic> {
                'tx_index': inId,
                'value': inValue,
              }
            }
          ],
          'out': [
            <String, dynamic>{
              'tx_index': outId,
              'value': outValue,
            }
          ],
        };

        final transaction = Transaction.fromJson(json);
        expect(transaction.id, hash);
        expect(transaction.relayedBy, relayedBy);

        expect(transaction.inputs.length, 1);
        expect(transaction.inputs[0].id, inId);
        expect(transaction.inputs[0].value, inValue.toDouble());

        expect(transaction.outputs.length, 1);
        expect(transaction.outputs[0].id, outId);
        expect(transaction.outputs[0].value, outValue.toDouble());
      });

      test('malformed json', () {
        final json = <String, dynamic>{};
        expect(() => Transaction.fromJson(json), throwsException);
      });
    });

    test('netInput', () {
      final transaction = Transaction(
        id: 'id',
        relayedBy: 'relayedBy',
        inputs: [
          const IO(id: 100, value: 100),
          const IO(id: 200, value: 200),
          const IO(id: 300, value: 300),
        ],
        outputs: [],
      );

      final netInput = transaction.netInput;
      expect(netInput, 600);
    });

    test('netOutput', () {
      final transaction = Transaction(
        id: 'id',
        relayedBy: 'relayedBy',
        inputs: [],
        outputs: [
          const IO(id: 100, value: 100),
          const IO(id: 200, value: 200),
          const IO(id: 300, value: 300),
        ],
      );

      final netOutput = transaction.netOutput;
      expect(netOutput, 600);
    });

    test('fee', () {
      final transaction = Transaction(
        id: 'id',
        relayedBy: 'relayedBy',
        inputs: [
          const IO(id: 101, value: 100),
          const IO(id: 202, value: 200),
        ],
        outputs: [
          const IO(id: 100, value: 100),
          const IO(id: 200, value: 200),
          const IO(id: 300, value: 300),
        ],
      );

      final fee = transaction.fee;
      expect(fee, 300);
    });
  });
}