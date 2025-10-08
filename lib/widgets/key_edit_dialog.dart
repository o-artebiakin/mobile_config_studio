import 'package:flutter/material.dart';

class KeyEditDialog extends StatefulWidget {
  final String title;
  final String initialKey;
  final String initialValue;
  final void Function(String key, String value) onSave;

  const KeyEditDialog({
    super.key,
    required this.title,
    this.initialKey = '',
    this.initialValue = '',
    required this.onSave,
  });

  @override
  State<KeyEditDialog> createState() => _KeyEditDialogState();

  static Future<void> show(
    BuildContext context, {
    required String title,
    String initialKey = '',
    String initialValue = '',
    required void Function(String key, String value) onSave,
  }) {
    return showDialog(
      context: context,
      builder: (context) => KeyEditDialog(
        title: title,
        initialKey: initialKey,
        initialValue: initialValue,
        onSave: onSave,
      ),
    );
  }
}

class _KeyEditDialogState extends State<KeyEditDialog> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(text: widget.initialKey);
    _valueController = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(
        _keyController.text.trim(),
        _valueController.text.trim(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _keyController,
              decoration: const InputDecoration(
                labelText: 'Key',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Key cannot be empty';
                }
                return null;
              },
              autofocus: widget.initialKey.isEmpty,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(
                labelText: 'Value',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Value cannot be empty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _handleSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
