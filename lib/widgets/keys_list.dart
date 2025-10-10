import 'package:flutter/material.dart';

import '../models/config_key.dart';

import 'key_list_item.dart';

class KeysList extends StatelessWidget {
  final List<ConfigKey> keys;
  final void Function(int index, ConfigKey key) onEdit;
  final void Function(ConfigKey key) onDelete;
  final String? newlyAddedKey;
  final GlobalKey? newItemKey;

  const KeysList({
    super.key,
    required this.keys,
    required this.onEdit,
    required this.onDelete,
    this.newlyAddedKey,
    this.newItemKey,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final key = keys[index];
        final isNew = newlyAddedKey != null && key.key == newlyAddedKey;
        return KeyListItem(
          key: isNew && newItemKey != null 
              ? newItemKey 
              : ValueKey('${key.key}_${key.value}'),
          configKey: key,
          onEdit: () => onEdit(index, key),
          onDelete: () => onDelete(key),
          isNew: isNew,
        );
      },
    );
  }
}
