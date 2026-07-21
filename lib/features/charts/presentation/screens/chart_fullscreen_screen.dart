import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../providers/charts_providers.dart';

/// Full-screen, pinch-to-zoom chart viewer with a save/share action.
class ChartFullscreenScreen extends ConsumerWidget {
  const ChartFullscreenScreen({super.key, required this.chartName, required this.title});

  final String chartName;
  final String title;

  Future<void> _saveOrShare(BuildContext context, List<int> bytes) async {
    try {
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$chartName');
      await file.writeAsBytes(bytes);
      await Share.shareXFiles([XFile(file.path)], text: title);
    } catch (_) {
      if (context.mounted) {
        SnackbarUtils.showError(context, 'Could not save the image.');
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageAsync = ref.watch(chartImageProvider(chartName));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          imageAsync.maybeWhen(
            data: (bytes) => IconButton(
              icon: const Icon(Icons.ios_share_rounded),
              onPressed: () => _saveOrShare(context, bytes),
              tooltip: 'Save / Share',
            ),
            orElse: () => const SizedBox.shrink(),
          ),
        ],
      ),
      body: imageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (error, _) => ErrorView(error: error),
        data: (bytes) => Hero(
          tag: 'chart-$chartName',
          child: PhotoView(
            imageProvider: MemoryImage(bytes),
            backgroundDecoration: const BoxDecoration(color: Colors.black),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
          ),
        ),
      ),
    );
  }
}
