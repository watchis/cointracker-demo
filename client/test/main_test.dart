import 'package:flutter_test/flutter_test.dart';

import 'package:client/main.dart';

void main() {
  testWidgets('Base components render', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    expect(find.text('My Addresses'), findsOneWidget);
    expect(find.text('Sync'), findsOneWidget);
    expect(find.text('Fetch'), findsOneWidget);
  });
}
