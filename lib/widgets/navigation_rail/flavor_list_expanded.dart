import 'package:flutter/material.dart';

import '../../models/config_flavor.dart';
import '../../providers/config_provider.dart';

/// Displays flavors in expanded state with full ListTile
class FlavorListExpanded extends StatelessWidget {
  final List<ConfigFlavor> flavors;
  final String? selectedFlavorName;
  final ConfigNotifier notifier;
  final Function(BuildContext, String, ConfigNotifier) onDelete;

  const FlavorListExpanded({
    super.key,
    required this.flavors,
    required this.selectedFlavorName,
    required this.notifier,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (flavors.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          'No flavors yet',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: flavors.map((flavor) {
        final isSelected = selectedFlavorName == flavor.name;
        return ListTile(
          dense: true,
          selected: isSelected,
          leading: Icon(
            isSelected ? Icons.label : Icons.label_outline,
            size: 20,
          ),
          title: Text(flavor.name, overflow: TextOverflow.ellipsis),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: Theme.of(context).colorScheme.error,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Delete ${flavor.name}',
            onPressed: () => onDelete(context, flavor.name, notifier),
          ),
          onTap: () => notifier.selectFlavor(flavor.name),
        );
      }).toList(),
    );
  }
}
