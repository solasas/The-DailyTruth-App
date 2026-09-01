import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/local/hive_boxes.dart';
import '../../../core/network/dio_client.dart';
import '../domain/repositories/settings_repository.dart';
import 'settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._localDataSource, this._dioClient);

  final SettingsLocalDataSource _localDataSource;
  final DioClient _dioClient;

  @override
  ThemeMode getThemeMode() => _localDataSource.getThemeMode();

  @override
  Future<void> setThemeMode(ThemeMode mode) =>
      _localDataSource.setThemeMode(mode);

  @override
  String getApiBaseUrl() => _localDataSource.getApiBaseUrl();

  @override
  Future<void> setApiBaseUrl(String baseUrl) async {
    await _localDataSource.setApiBaseUrl(baseUrl);
    _dioClient.updateBaseUrl(baseUrl);
  }

  @override
  Future<void> clearCache() async {
    if (Hive.isBoxOpen(HiveBoxes.predictionHistory)) {
      await Hive.box(HiveBoxes.predictionHistory).clear();
    }
  }
}
