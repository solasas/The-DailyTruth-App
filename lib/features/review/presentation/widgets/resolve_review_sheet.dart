import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/snackbar_utils.dart';
import '../../../../core/widgets/loading_button.dart';
import '../../domain/entities/review_queue_item.dart';
import '../providers/review_providers.dart';

/// Bottom sheet for `POST /review-queue/{id}/resolve`: pick a decision, add
/// an optional note, submit.
class ResolveReviewSheet extends ConsumerStatefulWidget {
  const ResolveReviewSheet({super.key, required this.item});

  final ReviewQueueItem item;

  static Future<void> show(BuildContext context, ReviewQueueItem item) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ResolveReviewSheet(item: item),
    );
  }

  @override
  ConsumerState<ResolveReviewSheet> createState() => _ResolveReviewSheetState();
}

class _ResolveReviewSheetState extends ConsumerState<ResolveReviewSheet> {
  ReviewDecision _decision = ReviewDecision.uncertain;
  final _noteController = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      await ref
          .read(reviewQueueControllerProvider.notifier)
          .resolve(
            id: widget.item.id,
            decision: _decision.wireValue,
            note: _noteController.text,
          );
      if (!mounted) return;
      Navigator.of(context).pop();
      SnackbarUtils.showSuccess(context, 'Item resolved as ${_decision.label}');
    } catch (error) {
      if (!mounted) return;
      setState(() => _submitting = false);
      SnackbarUtils.showError(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 4, 20, 20 + bottomInset),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Resolve review item', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            widget.item.textPreview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Text('Analyst decision', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          SegmentedButton<ReviewDecision>(
            segments: [
              for (final d in ReviewDecision.values)
                ButtonSegment(value: d, label: Text(d.label)),
            ],
            selected: {_decision},
            onSelectionChanged: _submitting
                ? null
                : (s) => setState(() => _decision = s.first),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            maxLines: 3,
            minLines: 2,
            enabled: !_submitting,
            decoration: const InputDecoration(
              labelText: 'Note (optional)',
              hintText: 'Rationale, sources checked, etc.',
            ),
          ),
          const SizedBox(height: 20),
          LoadingButton(
            label: 'Submit resolution',
            icon: Icons.check_rounded,
            isLoading: _submitting,
            onPressed: _submitting ? null : _submit,
          ),
        ],
      ),
    );
  }
}
