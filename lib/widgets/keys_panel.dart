import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/config_key.dart';
import '../providers/config_provider.dart';

import 'add_key_button.dart';
import 'key_delete_dialog.dart';
import 'key_edit_dialog.dart';
import 'keys_empty_state.dart';
import 'keys_list.dart';
import 'keys_panel_header.dart';
import 'keys_table_header.dart';

class KeysPanel extends ConsumerWidget {
  final VoidCallback onAddKey;

  const KeysPanel({
    super.key,
    required this.onAddKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(configProvider);
    final configNotifier = ref.read(configProvider.notifier);
    final keys = configState.selectedKeys;
    final hasSelectedGroup = configState.selectedGroupName.isNotEmpty;

    return Column(
      children: [
        KeysPanelHeader(
          groupName: configState.selectedGroupName,
          keyCount: keys.length,
        ),
        const KeysTableHeader(),
        Expanded(
          child: !hasSelectedGroup
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_off,
                        size: 64,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant
                            .withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No group selected',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create or select a group to add configuration keys',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant
                                  .withValues(alpha: 0.7),
                            ),
                      ),
                    ],
                  ),
                )
              : (keys.isEmpty
                  ? const KeysEmptyState()
                  : KeysList(
                      keys: keys,
                      onEdit: (index, key) => _handleEditKey(
                        context,
                        index,
                        key,
                        configNotifier,
                        configState,
                      ),
                      onDelete: (key) => _handleDeleteKey(
                        context,
                        key,
                        configNotifier,
                        configState,
                      ),
                    )),
        ),
        if (hasSelectedGroup)
          AddKeyButton(
            onPressed: onAddKey,
          ),
      ],
    );
  }

  void _handleEditKey(
    BuildContext context,
    int index,
    ConfigKey key,
    ConfigNotifier notifier,
    ConfigState state,
  ) {
    KeyEditDialog.show(
      context,
      title: 'Edit Key',
      initialKey: key.key,
      initialValue: key.value,
      onSave: (newKey, newValue) {
        notifier.updateKey(
          state.selectedGroupName,
          index,
          ConfigKey(key: newKey, value: newValue),
        );
      },
    );
  }

  void _handleDeleteKey(
    BuildContext context,
    ConfigKey key,
    ConfigNotifier notifier,
    ConfigState state,
  ) {
    KeyDeleteDialog.show(
      context,
      configKey: key,
      notifier: notifier,
      groupName: state.selectedGroupName,
    );
  }
}
