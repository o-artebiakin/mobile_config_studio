import 'package:flutter/material.dart';

import '../../models/config_group.dart';
import '../../providers/config_provider.dart';

/// Displays groups in expanded state with full ListTile
class GroupListExpanded extends StatelessWidget {
  final List<ConfigGroup> groups;
  final String? selectedGroupName;
  final ConfigNotifier notifier;
  final Function(BuildContext, String, ConfigNotifier) onDelete;
  final bool hasFlavors;

  const GroupListExpanded({
    super.key,
    required this.groups,
    required this.selectedGroupName,
    required this.notifier,
    required this.onDelete,
    required this.hasFlavors,
  });

  @override
  Widget build(BuildContext context) {
    if (groups.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          hasFlavors ? 'No groups yet' : 'Add a flavor first',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: groups.map((group) {
        final isSelected = selectedGroupName == group.name;
        return ListTile(
          dense: true,
          selected: isSelected,
          leading: Icon(
            isSelected ? Icons.folder : Icons.folder_outlined,
            size: 20,
          ),
          title: Text(group.name, overflow: TextOverflow.ellipsis, maxLines: 1),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_outline,
              size: 18,
              color: Theme.of(context).colorScheme.error,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            tooltip: 'Delete ${group.name}',
            onPressed: () => onDelete(context, group.name, notifier),
          ),
          onTap: () => notifier.selectGroup(group.name),
        );
      }).toList(),
    );
  }
}
