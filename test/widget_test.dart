import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_daily_truth/app.dart';
import 'package:the_daily_truth/core/local/hive_boxes.dart';
import 'package:the_daily_truth/core/providers/core_providers.dart';

void main() {
  setUpAll(() async {
    Hive.init(Directory.systemTemp.createTempSync('daily_truth_test').path);
    await Hive.openBox(HiveBoxes.predictionHistory);
  });

  testWidgets('App boots and shows the bottom navigation bar', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
        child: const TheDailyTruthApp(),
      ),
    );
    // Advance past the dashboard cards' staggered FadeSlideIn entrance
    // timers (see core/widgets/fade_slide_in.dart) without using
    // pumpAndSettle, which would hang on the shimmer skeletons' repeating
    // animation while the (unreachable, in this test) backend calls are
    // in flight.
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Check'), findsOneWidget);
    expect(find.text('Models'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
