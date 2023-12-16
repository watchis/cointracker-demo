import 'dart:async';

import 'package:client/components/cards/address_card.dart';
import 'package:client/models/address_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AddressInfo buildAddressInfo({
    String title = '',
    String id = '',
    double balance = 0.0,
  }) {
    return AddressInfo(
        title: title,
        id: id,
        received: 0,
        sent: 0,
        balance: balance,
        numTransactions: 0,
        transactions: [],
    );
  }

  group('Address Card', () {
    testWidgets('Base component renders', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.rtl,
        child: AddressCard(
          addressInfo: buildAddressInfo(
            title: 'SomeTitle',
            id: 'SomeID',
            balance: 123456789.00,
          ),
          onSelect: (_) {},
        ),
      ));

      expect(find.text('SomeTitle'), findsOneWidget);
      expect(find.text('SomeID'), findsOneWidget);
      expect(find.text('1.23456789 BTC'), findsOneWidget);
    });

    testWidgets('onSelect called on tap', (WidgetTester tester) async {
      final completer = Completer();

      // Build our app and trigger a frame.
      await tester.pumpWidget(Directionality(
        textDirection: TextDirection.rtl,
        child: AddressCard(
          addressInfo: buildAddressInfo(id: 'testId'),
          onSelect: (id) {
            completer.complete();
            expect(id, 'testId');
          },
        ),
      ));

      await tester.tap(find.text('testId'));
      await tester.pump();

      expect(completer.future, completes);
    });
  });
}
