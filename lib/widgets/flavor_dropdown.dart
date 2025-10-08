import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/config_provider.dart';

class FlavorDropdown extends ConsumerWidget {
  const FlavorDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(configProvider);
    final notifier = ref.read(configProvider.notifier);

    if (state.flavors.isEmpty) {
      return TextButton.icon(
        onPressed: () => _showAddFlavorDialog(context, notifier),
        icon: const Icon(Icons.add, size: 20),
        label: const Text('Add Flavor'),
      );
    }

    // Compact mode for AppBar
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          constraints: BoxConstraints(maxWidth: 150),
          child: DropdownButton<String>(
            value: state.selectedFlavorName.isEmpty
                ? null
                : state.selectedFlavorName,
            underline: const SizedBox(),
            isDense: true,
            borderRadius: BorderRadius.circular(8),
            menuWidth: 150,
            items: [
              // Regular flavor items
              ...state.flavors.map<DropdownMenuItem<String>>((flavor) {
                return DropdownMenuItem<String>(
                  value: flavor.name,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          flavor.name,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          size: 18,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        tooltip: 'Delete ${flavor.name}',
                        onPressed: () {
                          // Close dropdown first
                          Navigator.of(context).pop();
                          // Then show delete confirmation
                          _showDeleteFlavorDialog(
                            context,
                            notifier,
                            flavor.name,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }),
              // Add new flavor item (special item)
              DropdownMenuItem<String>(
                value: '__add_new_flavor__',
                child: Column(
                  children: [
                    Divider(),
                    Text(
                      'Add Flavor',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            selectedItemBuilder: (context) => state.flavors
                .map(
                  (flavor) => ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      state.selectedFlavorName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value == '__add_new_flavor__') {
                // Show add flavor dialog
                _showAddFlavorDialog(context, notifier);
              } else if (value != null) {
                notifier.selectFlavor(value);
              }
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  void _showAddFlavorDialog(BuildContext context, ConfigNotifier notifier) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Flavor'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Flavor Name',
            hintText: 'e.g., Development, Staging, Production',
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              notifier.addFlavor(value);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                notifier.addFlavor(controller.text);
                notifier.selectFlavor(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showDeleteFlavorDialog(
    BuildContext context,
    ConfigNotifier notifier,
    String flavorName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flavor'),
        content: Text(
          'Are you sure you want to delete the flavor "$flavorName"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              notifier.deleteFlavor(flavorName);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
