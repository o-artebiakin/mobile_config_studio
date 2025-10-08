import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/config_provider.dart';
import '../services/config_actions.dart';
import '../widgets/flavor_dropdown.dart';
import '../widgets/groups_sidebar.dart';
import '../widgets/keys_panel.dart';

class HomeScreen extends HookConsumerWidget {
  final String? configParam;
  
  const HomeScreen({
    super.key,
    this.configParam,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = ConfigActions(context, ref);
    final state = ref.watch(configProvider);
    
    // Load config from URL parameter on first build
    useEffect(() {
      if (configParam != null && configParam!.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          try {
            // Decode base64
            final decodedBytes = base64Decode(configParam!);
            final jsonString = utf8.decode(decodedBytes);
            final configData = jsonDecode(jsonString) as Map<String, dynamic>;
            
            // Load into state
            ref.read(configProvider.notifier).loadFromJson(configData);
            
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Configuration loaded from URL'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.green,
              ),
            );
          } catch (e) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error loading configuration: $e'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
          }
        });
      }
      return null;
    }, [configParam]); // Re-run if configParam changes

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Config Studio'),
            const SizedBox(width: 24),
            // Flavor selector in AppBar
            FlavorDropdown(),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_upload),
            tooltip: 'Import',
            onPressed: actions.importConfig,
          ),
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Export',
            onPressed: actions.exportConfig,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
            onPressed: actions.resetConfig,
          ),
        ],
      ),
      body: Row(
        children: [
          GroupsSidebar(
            onAddGroup: actions.addGroup,
          ),
          Expanded(
            child: KeysPanel(
              onAddKey: actions.addKey,
            ),
          ),
        ],
      ),
      floatingActionButton: state.hasUnsavedChanges
          ? FloatingActionButton.extended(
              onPressed: actions.saveConfig,
              icon: const Icon(Icons.save),
              label: const Text('Save Config'),
            )
          : null,
    );
  }
}
