import 'package:hive_flutter/hive_flutter.dart';

/// Registered Hive box names, opened once at startup in `main.dart`.
class HiveBoxes {
  HiveBoxes._();

  static const String predictionHistory = 'prediction_history_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(predictionHistory);
  }
}
