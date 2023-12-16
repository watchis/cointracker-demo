import 'package:client/components/dialogs/delete_address_dialog.dart';
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
            child: DeleteAddressDialog(onDelete: () {}),
          ),
        ),
      ));

      expect(find.text('Delete Address'), findsOneWidget);
      expect(find.text('Are you sure you want to delete this address?'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Delete'), findsOneWidget);
    });
  });
}
