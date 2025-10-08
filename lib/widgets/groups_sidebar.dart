import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/config_provider.dart';

class GroupsSidebar extends ConsumerWidget {
  final VoidCallback onAddGroup;

  const GroupsSidebar({
    super.key,
    required this.onAddGroup,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(configProvider);
    final configNotifier = ref.read(configProvider.notifier);

    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Groups',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: configState.groups.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No groups yet.\nClick "Add Group" to get started.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: configState.groups.length,
                    itemBuilder: (context, index) {
                      final group = configState.groups[index];
                      final isSelected = configState.selectedGroupName == group.name;

                      return ListTile(
                        title: Text(group.name),
                        selected: isSelected,
                        onTap: () => configNotifier.selectGroup(group.name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, size: 18),
                          onPressed: () => _confirmDeleteGroup(context, group.name, configNotifier),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onAddGroup,
                icon: const Icon(Icons.add),
                label: const Text('Add Group'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteGroup(BuildContext context, String groupName, ConfigNotifier notifier) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Group'),
        content: Text('Are you sure you want to delete "$groupName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              notifier.deleteGroup(groupName);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
