import 'dart:async';

import 'package:client/components/cards/transaction_card.dart';
import 'package:client/models/io.dart';
import 'package:client/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Transaction buildTransaction({
    String id = '',
    double inputVal = 10,
    double outputVal = 20,
  }) {
    return Transaction(
        id: id,
        relayedBy: '',
        inputs: [IO(id: 1, value: inputVal)],
        outputs: [IO(id: 2, value: outputVal)],
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
      expect(find.text('0.00000010'), findsOneWidget);
      expect(find.text('Outgoing:'), findsOneWidget);
      expect(find.text('0.00000020'), findsOneWidget);
      expect(find.text('Fee:'), findsOneWidget);
      expect(find.text('10.0 Sats'), findsOneWidget);
    });
  });
}
