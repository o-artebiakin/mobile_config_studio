import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CommandControlsSection extends HookWidget {
  final ValueNotifier<String> selectedCommand;
  final ValueNotifier<String?> selectedFlavor;
  final ValueNotifier<bool> usePlaceholders;
  final List<String> availableFlavors;

  const CommandControlsSection({
    super.key,
    required this.selectedCommand,
    required this.selectedFlavor,
    required this.usePlaceholders,
    required this.availableFlavors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: selectedCommand.value,
                decoration: const InputDecoration(
                  labelText: 'Command',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: const [
                  DropdownMenuItem(value: 'run', child: Text('flutter run')),
                  DropdownMenuItem(
                    value: 'build',
                    child: Text('flutter build'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    selectedCommand.value = value;
                  }
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: DropdownButtonFormField<String?>(
                initialValue: selectedFlavor.value,
                decoration: const InputDecoration(
                  labelText: 'Flavor (optional)',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                items: [
                  const DropdownMenuItem(value: null, child: Text('None')),
                  ...availableFlavors.map(
                    (flavor) => DropdownMenuItem(
                      value: flavor,
                      child: Text(flavor),
                    ),
                  ),
                ],
                onChanged: (value) {
                  selectedFlavor.value = value;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: const Text('Use placeholders for values'),
          subtitle: const Text(
            'Replace actual values with <value> placeholders for documentation',
            style: TextStyle(fontSize: 12),
          ),
          value: usePlaceholders.value,
          onChanged: (value) {
            if (value != null) {
              usePlaceholders.value = value;
            }
          },
        ),
      ],
    );
  }
}
