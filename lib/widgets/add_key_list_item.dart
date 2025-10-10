import 'package:flutter/material.dart';

class AddKeyListItem extends StatefulWidget {
  final void Function(String key, String value) onAdd;

  const AddKeyListItem({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddKeyListItem> createState() => _AddKeyListItemState();
}

class _AddKeyListItemState extends State<AddKeyListItem> {
  final _keyController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final key = _keyController.text.trim();
    final value = _valueController.text.trim();
    
    if (key.isNotEmpty && value.isNotEmpty) {
      widget.onAdd(key, value);
      _keyController.clear();
      _valueController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              controller: _keyController,
              decoration: InputDecoration(
                hintText: 'Enter key name',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontWeight: FontWeight.w500),
              onSubmitted: (_) => _handleAdd(),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextField(
              controller: _valueController,
              decoration: InputDecoration(
                hintText: 'Enter value',
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onSubmitted: (_) => _handleAdd(),
            ),
          ),
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  tooltip: 'Add',
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: _handleAdd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
