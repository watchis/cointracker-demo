import 'package:client/models/io.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transaction', () {
    group('fromJson', () {
      test('well-formed json', () {
        const hash = 'hashId';
        const inId = "100", inValue = 250;
        const outId = "500", outValue = 750;

        final json = <String, dynamic>{
          'hash': hash,
          'block_index': null,
          'inputs': [
            <String, dynamic>{
              'prev_out': <String, dynamic> {
                'addr': inId,
                'value': inValue,
              }
            }
          ],
          'out': [
            <String, dynamic>{
              'addr': outId,
              'value': outValue,
            }
          ],
        };

        final transaction = Transaction.fromJson('parentId', json);
        expect(transaction.id, hash);
        expect(transaction.isPending, true);

        expect(transaction.inputs.length, 1);
        expect(transaction.inputs[0].targetAddressId, inId);
        expect(transaction.inputs[0].value, inValue.toDouble());

        expect(transaction.outputs.length, 1);
        expect(transaction.outputs[0].targetAddressId, outId);
        expect(transaction.outputs[0].value, outValue.toDouble());
      });

      test('malformed json', () {
        final json = <String, dynamic>{};
        expect(() => Transaction.fromJson('parentId', json), throwsException);
      });
    });

    test('netInput', () {
      final transaction = Transaction(
        parentId: '300',
        id: 'id',
        isPending: true,
        inputs: [
          const IO(targetAddressId: "100", value: 100),
          const IO(targetAddressId: "200", value: 200),
          const IO(targetAddressId: "300", value: 300),
        ],
        outputs: [],
      );

      final netInput = transaction.addressInput;
      expect(netInput, 300);
    });

    test('netOutput', () {
      final transaction = Transaction(
        parentId: '200',
        id: 'id',
        isPending: true,
        inputs: [],
        outputs: [
          const IO(targetAddressId: "100", value: 100),
          const IO(targetAddressId: "200", value: 200),
          const IO(targetAddressId: "300", value: 300),
        ],
      );

      final netOutput = transaction.addressOutput;
      expect(netOutput, 200);
    });

    test('fee', () {
      final transaction = Transaction(
        parentId: 'parent',
        id: 'id',
        isPending: true,
        inputs: [
          const IO(targetAddressId: "101", value: 100),
          const IO(targetAddressId: "202", value: 200),
        ],
        outputs: [
          const IO(targetAddressId: "100", value: 100),
          const IO(targetAddressId: "200", value: 200),
          const IO(targetAddressId: "300", value: 300),
        ],
      );

      final fee = transaction.fee;
      expect(fee, 300);
    });
  });
}