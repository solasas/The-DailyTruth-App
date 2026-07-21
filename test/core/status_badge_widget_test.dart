import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_daily_truth/core/widgets/status_badge.dart';

void main() {
  testWidgets('StatusBadge renders its label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: StatusBadge(label: 'Loaded', color: Colors.green, icon: Icons.check_circle),
        ),
      ),
    );

    expect(find.text('Loaded'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}
