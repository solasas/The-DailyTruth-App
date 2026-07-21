import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/gradient_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/settings_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _urlController;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: ref.read(apiBaseUrlProvider));
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _saveBaseUrl() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;
    await ref.read(apiBaseUrlProvider.notifier).setApiBaseUrl(url);
    if (mounted) SnackbarUtils.showSuccess(context, 'API base URL updated');
  }

  Future<void> _clearCache() async {
    await ref.read(settingsRepositoryProvider).clearCache();
    if (mounted) SnackbarUtils.showSuccess(context, 'Local cache cleared');
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Appearance', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SoftCard(
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Dark Mode'),
              subtitle: Text(_themeModeLabel(themeMode)),
              value: themeMode == ThemeMode.dark,
              onChanged: (value) {
                ref
                    .read(themeModeProvider.notifier)
                    .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
              secondary: const Icon(Icons.dark_mode_rounded),
            ),
          ),
          const SizedBox(height: 24),
          Text('Backend', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SoftCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('API Base URL', style: theme.textTheme.bodyMedium),
                const SizedBox(height: 8),
                TextField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(hintText: 'https://your-api-host'),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(onPressed: _saveBaseUrl, child: const Text('Save')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Storage', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SoftCard(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.delete_sweep_rounded, color: AppColors.error),
              title: const Text('Clear Cache'),
              subtitle: const Text('Removes locally stored prediction history'),
              trailing: OutlinedButton(onPressed: _clearCache, child: const Text('Clear')),
            ),
          ),
          const SizedBox(height: 24),
          Text('About', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          SoftCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.shield_moon_rounded, color: AppColors.primary),
                  title: const Text(AppConstants.appName),
                  subtitle: const Text(AppConstants.appTagline),
                ),
                const Divider(),
                FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshot) {
                    final version = snapshot.data?.version ?? AppConstants.appVersion;
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.info_outline_rounded),
                      title: const Text('App Version'),
                      trailing: Text(version, style: theme.textTheme.bodyMedium),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Light theme',
    ThemeMode.dark => 'Dark theme',
    ThemeMode.system => 'Follows system',
  };
}
