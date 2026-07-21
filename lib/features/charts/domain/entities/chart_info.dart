import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_info.freezed.dart';

/// A single chart made available by `GET /results/charts`, identified by
/// its backend filename (used to fetch bytes from
/// `GET /results/charts/{name}`).
@freezed
class ChartInfo with _$ChartInfo {
  const factory ChartInfo({required String name, required String title}) = _ChartInfo;
}
