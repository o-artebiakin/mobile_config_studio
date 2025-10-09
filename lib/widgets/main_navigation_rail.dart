import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/config_provider.dart';

import 'navigation_rail/flavor_list_collapsed.dart';
import 'navigation_rail/flavor_list_expanded.dart';
import 'navigation_rail/group_list_collapsed.dart';
import 'navigation_rail/group_list_expanded.dart';
import 'navigation_rail/navigation_rail_actions.dart';
import 'navigation_rail/navigation_rail_header.dart';
import 'navigation_rail/navigation_section_header.dart';

class MainNavigationRail extends HookConsumerWidget {
  final VoidCallback onAddGroup;
  final VoidCallback onImport;
  final VoidCallback onExport;

  const MainNavigationRail({
    super.key,
    required this.onAddGroup,
    required this.onImport,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configState = ref.watch(configProvider);
    final configNotifier = ref.read(configProvider.notifier);
    final isExpanded = useState(true);
    final showFlavors = useState(true);
    final showGroups = useState(true);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: isExpanded.value ? 280 : 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMinimizedSize = constraints.maxWidth < 100;

          return Column(
            children: [
              // App Header
              NavigationRailHeader(isExpanded:  !isMinimizedSize),
              const Divider(height: 1),
          
              // Flavors & Groups Section
              Expanded(
                child: ListView(
                  children: [
                    // Flavors Section
                    NavigationSectionHeader(
                      title: 'Flavors',
                      isExpanded: showFlavors.value,
                      isCollapsed: isMinimizedSize,
                      onToggle: () => showFlavors.value = !showFlavors.value,
                      onAdd: () => _showAddFlavorDialog(context, configNotifier),
                      collapsedIcon: Icons.style,
                    ),
                    if (showFlavors.value && !isMinimizedSize)
                      FlavorListExpanded(
                        flavors: configState.flavors,
                        selectedFlavorName: configState.selectedFlavorName,
                        notifier: configNotifier,
                        onDelete: _confirmDeleteFlavor,
                      ),
                    if (showFlavors.value && isMinimizedSize)
                      FlavorListCollapsed(
                        flavors: configState.flavors,
                        selectedFlavorName: configState.selectedFlavorName,
                        notifier: configNotifier,
                      ),
          
                    const Divider(height: 1),
          
                    // Groups Section
                    NavigationSectionHeader(
                      title: 'Groups',
                      isExpanded: showGroups.value,
                      isCollapsed: isMinimizedSize,
                      onToggle: () => showGroups.value = !showGroups.value,
                      onAdd: configState.flavors.isEmpty ? null : onAddGroup,
                      collapsedIcon: Icons.workspaces_outlined,
                    ),
                    if (showGroups.value && !isMinimizedSize)
                      GroupListExpanded(
                        groups: configState.groups,
                        selectedGroupName: configState.selectedGroupName,
                        notifier: configNotifier,
                        onDelete: _confirmDeleteGroup,
                        hasFlavors: configState.flavors.isNotEmpty,
                      ),
                    if (showGroups.value && isMinimizedSize)
                      GroupListCollapsed(
                        groups: configState.groups,
                        selectedGroupName: configState.selectedGroupName,
                        notifier: configNotifier,
                      ),
                  ],
                ),
              ),
          
              // Bottom Controls
              const Divider(height: 1),
              NavigationRailActions(
                isExpanded: !isMinimizedSize,
                onImport: onImport,
                onExport: onExport,
              ),
              const Divider(height: 1),
              Align(
                alignment: isExpanded.value
                    ? Alignment.centerRight
                    : Alignment.center,
                child: IconButton(
                  onPressed: () => isExpanded.value = !isExpanded.value,
                  icon: Icon(
                    isExpanded.value ? Icons.chevron_left : Icons.chevron_right,
                  ),
                  tooltip: isExpanded.value ? 'Collapse' : 'Expand',
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void _showAddFlavorDialog(BuildContext context, ConfigNotifier notifier) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Flavor'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Flavor Name',
            hintText: 'e.g., Development, Staging, Production',
          ),
          autofocus: true,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              notifier.addFlavor(value);
              Navigator.pop(context);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                notifier.addFlavor(controller.text);
                notifier.selectFlavor(controller.text);
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteFlavor(
    BuildContext context,
    String flavorName,
    ConfigNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Flavor'),
        content: Text(
          'Are you sure you want to delete the flavor "$flavorName"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              notifier.deleteFlavor(flavorName);
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteGroup(
    BuildContext context,
    String groupName,
    ConfigNotifier notifier,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Group'),
        content: Text('Are you sure you want to delete "$groupName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              notifier.deleteGroup(groupName);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
