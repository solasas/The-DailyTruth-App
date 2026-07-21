import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../local/hive_boxes.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';

/// Overridden in `main.dart` with the resolved instance obtained during
/// startup, before `runApp`. Kept as an unimplemented default so any
/// accidental read before override fails loudly instead of silently.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider was not overridden');
});

final connectivityProvider = Provider<Connectivity>((ref) => Connectivity());

final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl(ref.watch(connectivityProvider));
});

/// Emits `true`/`false` whenever device connectivity changes; used by the
/// offline banner and retry flows across the app.
final connectivityStatusProvider = StreamProvider<bool>((ref) {
  return ref.watch(networkInfoProvider).onConnectivityChanged;
});

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(networkInfo: ref.watch(networkInfoProvider));
});

final predictionHistoryBoxProvider = Provider<Box>((ref) {
  return Hive.box(HiveBoxes.predictionHistory);
});
