import 'package:flutter/material.dart';
import '../models/config_key.dart';
import '../providers/config_provider.dart';

class KeyDeleteDialog extends StatelessWidget {
  final ConfigKey configKey;
  final ConfigNotifier notifier;
  final String groupName;

  const KeyDeleteDialog({
    super.key,
    required this.configKey,
    required this.notifier,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete Key'),
      content: Text('Are you sure you want to delete "${configKey.key}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            notifier.deleteKey(groupName, configKey);
            Navigator.pop(context);
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  static Future<void> show(
    BuildContext context, {
    required ConfigKey configKey,
    required ConfigNotifier notifier,
    required String groupName,
  }) {
    return showDialog(
      context: context,
      builder: (context) => KeyDeleteDialog(
        configKey: configKey,
        notifier: notifier,
        groupName: groupName,
      ),
    );
  }
}
