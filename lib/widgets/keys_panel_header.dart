import 'package:flutter/material.dart';

class KeysPanelHeader extends StatelessWidget {
  final String groupName;
  final int keyCount;

  const KeysPanelHeader({
    super.key,
    required this.groupName,
    required this.keyCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              groupName.isEmpty ? 'No Group Selected' : groupName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: groupName.isEmpty 
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : null,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$keyCount ${keyCount == 1 ? 'key' : 'keys'}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
