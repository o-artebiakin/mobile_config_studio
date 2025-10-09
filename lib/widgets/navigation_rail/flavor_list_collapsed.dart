import 'package:flutter/material.dart';

import '../../models/config_flavor.dart';
import '../../providers/config_provider.dart';

/// Displays flavors in collapsed state with first letter only
class FlavorListCollapsed extends StatelessWidget {
  final List<ConfigFlavor> flavors;
  final String? selectedFlavorName;
  final ConfigNotifier notifier;

  const FlavorListCollapsed({
    super.key,
    required this.flavors,
    required this.selectedFlavorName,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: flavors.map((flavor) {
        final isSelected = selectedFlavorName == flavor.name;
        final firstLetter =
            flavor.name.isNotEmpty ? flavor.name[0].toUpperCase() : '?';

        return Tooltip(
          message: flavor.name,
          child: InkWell(
            onTap: () => notifier.selectFlavor(flavor.name),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: isSelected
                  ? BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                      ),
                    )
                  : null,
              child: Center(
                child: Text(
                  firstLetter,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
