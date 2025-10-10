import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/config_key.dart';
import '../providers/config_provider.dart';

import 'add_key_list_item.dart';
import 'key_delete_dialog.dart';
import 'key_edit_dialog.dart';
import 'keys_list.dart';
import 'keys_table_header.dart';

class KeysPanel extends ConsumerStatefulWidget {
  final VoidCallback onAddKey;

  const KeysPanel({super.key, required this.onAddKey});

  @override
  ConsumerState<KeysPanel> createState() => _KeysPanelState();
}

class _KeysPanelState extends ConsumerState<KeysPanel> {
  String? _newlyAddedKey;
  final Map<String, GlobalKey> _itemKeys = {};

  @override
  Widget build(BuildContext context) {
    final configState = ref.watch(configProvider);
    final configNotifier = ref.read(configProvider.notifier);
    final keys = configState.selectedKeysSorted;
    final hasSelectedGroup = configState.selectedGroupName.isNotEmpty;

    return Column(
      children: [
        const KeysTableHeader(),
        if (hasSelectedGroup)
          AddKeyListItem(
            onAdd: (key, value) =>
                _handleAddKey(context, key, value, configNotifier, configState),
          ),
        Expanded(
          child: !hasSelectedGroup
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_off,
                        size: 64,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No group selected',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create or select a group to add configuration keys',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : (keys.isEmpty
                    ? const SizedBox.shrink()
                    : KeysList(
                        keys: keys,
                        newlyAddedKey: _newlyAddedKey,
                        newItemKey: _newlyAddedKey != null
                            ? _itemKeys[_newlyAddedKey!]
                            : null,
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
      ],
    );
  }

  void _handleAddKey(
    BuildContext context,
    String key,
    String value,
    ConfigNotifier notifier,
    ConfigState state,
  ) {
    // Check if key already exists
    final existingKeys = state.selectedKeys;
    if (existingKeys.any((k) => k.key == key)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Key "$key" already exists in this group'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    notifier.addKey(state.selectedGroupName, ConfigKey(key: key, value: value));

    // Create a GlobalKey for the new item
    final itemKey = GlobalKey();
    _itemKeys[key] = itemKey;

    // Set the newly added key for animation
    setState(() {
      _newlyAddedKey = key;
    });

    // Scroll to the newly added element using Scrollable.ensureVisible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final itemContext = itemKey.currentContext;
      if (itemContext != null) {
        // Find the RenderBox to determine element position
        final renderBox = itemContext.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          // Get the element's position relative to the viewport
          final scrollable = Scrollable.of(itemContext);
          final viewport = RenderAbstractViewport.of(renderBox);
          
          final revealedOffset = viewport.getOffsetToReveal(renderBox, 0.0).offset;
          final currentOffset = scrollable.position.pixels;
          
          // Determine if element is above or below current scroll position
          final isAboveViewport = revealedOffset < currentOffset;
          
          // Use appropriate alignment policy based on position
          Scrollable.ensureVisible(
            itemContext,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            alignmentPolicy: isAboveViewport 
                ? ScrollPositionAlignmentPolicy.keepVisibleAtStart
                : ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
        }
      }
    });

    // Clear the newly added key after animation duration
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _newlyAddedKey = null;
        });
        _itemKeys.remove(key);
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Key "$key" added'),
        behavior: SnackBarBehavior.floating,
      ),
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
