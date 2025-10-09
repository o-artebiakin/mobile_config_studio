import 'package:flutter/material.dart';

import '../../models/config_group.dart';
import '../../providers/config_provider.dart';

/// Displays groups in collapsed state with first letter only
class GroupListCollapsed extends StatelessWidget {
  final List<ConfigGroup> groups;
  final String? selectedGroupName;
  final ConfigNotifier notifier;

  const GroupListCollapsed({
    super.key,
    required this.groups,
    required this.selectedGroupName,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: groups.map((group) {
        final isSelected = selectedGroupName == group.name;
        final firstLetter =
            group.name.isNotEmpty ? group.name[0].toUpperCase() : '?';

        return Tooltip(
          message: group.name,
          child: InkWell(
            onTap: () => notifier.selectGroup(group.name),
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
