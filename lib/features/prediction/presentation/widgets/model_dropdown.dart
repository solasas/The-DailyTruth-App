import 'package:flutter/material.dart';

import '../../../models/domain/entities/model_info.dart';

/// Dropdown of loaded models for the Analyze screen. Only models the
/// backend reports as `loaded` are selectable.
class ModelDropdown extends StatelessWidget {
  const ModelDropdown({
    super.key,
    required this.models,
    required this.selectedModel,
    required this.onChanged,
  });

  final List<ModelInfo> models;
  final String? selectedModel;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: models.any((m) => m.name == selectedModel) ? selectedModel : null,
      decoration: const InputDecoration(
        labelText: 'Model',
        prefixIcon: Icon(Icons.psychology_alt_rounded),
      ),
      hint: const Text('Select a model'),
      isExpanded: true,
      items: models
          .map(
            (model) => DropdownMenuItem(
              value: model.name,
              child: Text(
                '${model.displayName} · ${model.category}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
