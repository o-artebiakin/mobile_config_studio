import 'package:flutter/material.dart';

class AddKeyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddKeyButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.add),
          label: const Text('Add Key'),
        ),
      ),
    );
  }
}
