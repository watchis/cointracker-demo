import 'package:client/components/dialogs/edit_title_dialog.dart';
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
            child: EditTitleDialog(
              currentTitle: 'Current Title',
              onConfirm: (_) {},
            ),
          ),
        ),
      ));

      expect(find.text('Edit Address Title'), findsOneWidget);
      expect(find.text('Current Title'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Confirm'), findsOneWidget);
    });
  });
}
