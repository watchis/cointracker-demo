import 'package:client/components/dialogs/add_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Add Address Dialog', () {
    testWidgets('Base component renders', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(Directionality(
          textDirection: TextDirection.rtl,
          child: MaterialApp(
            home: Material(
              child: AddAddressDialog(onAddAddress: (_) {}),
            ),
          ),
      ));

      expect(find.text('New Address'), findsOneWidget);
      expect(find.text('Add address...'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });
  });
}
