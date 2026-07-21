import 'dart:typed_data';

import '../entities/chart_info.dart';

abstract class ChartsRepository {
  Future<List<ChartInfo>> getCharts();
  Future<Uint8List> getChartImage(String name);
}
