import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_config_studio/main.dart';

void main() {
  testWidgets('Config Studio smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: ConfigStudioApp(),
      ),
    );

    // Verify that the app bar is displayed
    expect(find.text('Config Studio'), findsOneWidget);

    // Verify that icons are present for empty state
    expect(find.byIcon(Icons.settings_applications), findsOneWidget);
  });
}