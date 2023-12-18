import 'package:client/components/cards/transaction_card.dart';
import 'package:client/models/io.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Transaction buildTransaction({
    String id = '',
  }) {
    return Transaction(
      parentId: '1',
      id: id,
      isPending: false,
      inputs: [const IO(targetAddressId: "1", value: 10)],
      outputs: [const IO(targetAddressId: "1", value: 20)],
    );
  }

  group('Transaction Card', () {
    testWidgets('Base component renders', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.rtl,
        child: TransactionCard(
          transaction: buildTransaction(id: 'SomeID'),
        ),
      ));

      expect(find.text('SomeID'), findsOneWidget);
      expect(find.text('Incoming:'), findsOneWidget);
      expect(find.text('0.00000020 BTC'), findsOneWidget);
      expect(find.text('Outgoing:'), findsOneWidget);
      expect(find.text('-0.00000010 BTC'), findsOneWidget);
      expect(find.text('Fee:'), findsOneWidget);
      expect(find.text('10 Sats'), findsOneWidget);
    });
  });
}
