import 'package:flutter/material.dart';

/// Consistent "Title" + optional trailing action used above list sections
/// (Recent Predictions, Quick Statistics, etc).
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.action});

  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        ?action,
      ],
    );
  }
}
