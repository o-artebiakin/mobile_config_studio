import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../models/config_key.dart';
import '../providers/config_provider.dart';

class ConfigActions {
  final BuildContext context;
  final WidgetRef ref;

  ConfigActions(this.context, this.ref);

  ConfigNotifier get _notifier => ref.read(configProvider.notifier);
  ConfigState get _state => ref.read(configProvider);

  void importConfig() {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Configuration'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Paste base64 encoded configuration:',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Base64 Config',
                  border: OutlineInputBorder(),
                  hintText: 'Paste base64 string here...',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a configuration';
                  }
                  try {
                    // Validate base64 and JSON
                    final decodedBytes = base64Decode(value.trim());
                    final jsonString = utf8.decode(decodedBytes);
                    jsonDecode(jsonString);
                    return null;
                  } catch (e) {
                    return 'Invalid base64 or JSON format';
                  }
                },
                autofocus: true,
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
            onPressed: () {
              if (formKey.currentState!.validate()) {
                try {
                  final decodedBytes = base64Decode(controller.text.trim());
                  final jsonString = utf8.decode(decodedBytes);
                  final configData = jsonDecode(jsonString) as Map<String, dynamic>;
                  
                  _notifier.loadFromJson(configData);
                  Navigator.pop(context);
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Configuration imported successfully'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Import failed: $e'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Import'),
          ),
        ],
      ),
    ).then((_) => controller.dispose());
  }

  void exportConfig() {
    final jsonData = _state.toJsonExport(); // Use custom export method
    final jsonString = jsonEncode(jsonData);
    final base64Encoded = base64Encode(utf8.encode(jsonString));
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Configuration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Base64 encoded configuration:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: SelectableText(
                base64Encoded,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: base64Encoded));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Base64 copied to clipboard'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.copy),
                    label: const Text('Copy Base64'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () async {
                      // Generate URL using go_router
                      String shareUrl;
                      if (kIsWeb) {
                        // For web, use the full URL with origin
                        final router = GoRouter.of(context);
                        final location = router.namedLocation('home', 
                          queryParameters: {'config': base64Encoded});
                        final origin = Uri.base.origin;
                        final basePath = Uri.base.path.replaceAll(RegExp(r'/$'), '');
                        shareUrl = '$origin$basePath$location';
                      } else {
                        // For mobile, use deep link format
                        shareUrl = 'configstudio://home?config=$base64Encoded';
                      }
                      
                      await Clipboard.setData(ClipboardData(text: shareUrl));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Share URL copied to clipboard'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.share),
                    label: const Text('Copy URL'),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void resetConfig() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Configuration'),
        content: const Text(
          'Are you sure you want to reset all configuration to default values? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              _notifier.reset();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Configuration reset to defaults'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }

  void addGroup() {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Group'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Group Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Group name cannot be empty';
              }
              if (_state.groups.any((g) => g.name == value.trim())) {
                return 'Group already exists';
              }
              return null;
            },
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _notifier.addGroup(controller.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Group "${controller.text.trim()}" added'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((_) => controller.dispose());
  }

  void addKey() {
    final keyController = TextEditingController();
    final valueController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Key'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: keyController,
                decoration: const InputDecoration(
                  labelText: 'Key',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Key cannot be empty';
                  }
                  final existingKeys = _state.selectedKeys;
                  if (existingKeys.any((k) => k.key == value.trim())) {
                    return 'Key already exists in this group';
                  }
                  return null;
                },
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: valueController,
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
            onPressed: () {
              if (formKey.currentState!.validate()) {
                _notifier.addKey(
                  _state.selectedGroupName,
                  ConfigKey(
                    key: keyController.text.trim(),
                    value: valueController.text.trim(),
                  ),
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Key "${keyController.text.trim()}" added'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    ).then((_) {
      keyController.dispose();
      valueController.dispose();
    });
  }

  void saveConfig() {
    // TODO: Implement actual save to persistent storage
    final jsonData = jsonEncode(_state.toJson());
    debugPrint('Save JSON: $jsonData');
    
    // Mark as saved
    ref.read(configProvider.notifier).markAsSaved();
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuration saved!'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
