import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/article_enums.dart';

/// Vertical step indicator shown while an article is `processing`.
class VerificationProgress extends StatelessWidget {
  const VerificationProgress({super.key, required this.stage});

  final ArticleStage stage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final current = stage.order;
    final steps = ArticleStageX.orderedSteps;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          _StepRow(
            label: steps[i].label,
            state: i < current
                ? _StepState.done
                : (i == current ? _StepState.active : _StepState.pending),
            isLast: i == steps.length - 1,
          ),
        const SizedBox(height: 12),
        Text(
          'Each stage times out after ${AppConstants.agenticStageTimeout.inSeconds}s; '
          'up to ${AppConstants.maxClaims} claims are checked.',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}

enum _StepState { done, active, pending }

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.label,
    required this.state,
    required this.isLast,
  });

  final String label;
  final _StepState state;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (state) {
      _StepState.done => theme.colorScheme.primary,
      _StepState.active => theme.colorScheme.primary,
      _StepState.pending => theme.disabledColor,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: switch (state) {
                  _StepState.done => Icon(
                    Icons.check_circle_rounded,
                    size: 22,
                    color: color,
                  ),
                  _StepState.active => const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2.4),
                  ),
                  _StepState.pending => Icon(
                    Icons.circle_outlined,
                    size: 22,
                    color: color,
                  ),
                },
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    color: state == _StepState.done
                        ? color
                        : theme.dividerColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 18, top: 1),
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: state == _StepState.active
                    ? FontWeight.w700
                    : FontWeight.w400,
                color: state == _StepState.pending ? theme.disabledColor : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
