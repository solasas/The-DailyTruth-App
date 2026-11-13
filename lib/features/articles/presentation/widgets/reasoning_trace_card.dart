import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/gradient_card.dart';

/// The server's plain-text explanation (it already contains every claim's
/// `ORIGIN TRAIL`). Monospace, whitespace preserved, horizontally scrollable,
/// collapsed by default, with a copy button.
class ReasoningTraceCard extends StatelessWidget {
  const ReasoningTraceCard({super.key, required this.trace});

  final String trace;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SoftCard(
      padding: EdgeInsets.zero,
      child: Material(
        type: MaterialType.transparency,
        child: Theme(
          data: theme.copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 16),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            title: Text('Reasoning trace', style: theme.textTheme.titleSmall),
            trailing: const Icon(Icons.expand_more_rounded),
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: trace));
                    if (context.mounted) {
                      SnackbarUtils.showSuccess(context, 'Trace copied');
                    }
                  },
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  label: const Text('Copy'),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SelectableText(
                  trace,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'Menlo',
                    fontFamilyFallback: const ['Roboto Mono', 'monospace'],
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
