import 'package:flutter/material.dart';

/// Expanded navigation rail action buttons (Import/Export)
class NavigationRailActionsExpanded extends StatelessWidget {
  final VoidCallback onImport;
  final VoidCallback onExport;

  const NavigationRailActionsExpanded({
    super.key,
    required this.onImport,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: TextButton.icon(
              onPressed: onImport,
              icon: const Icon(Icons.file_upload, size: 18),
              label: const Text(
                'Import',
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextButton.icon(
              onPressed: onExport,
              icon: const Icon(Icons.file_download, size: 18),
              label: const Text(
                'Export',
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Collapsed navigation rail action buttons (Import/Export)
class NavigationRailActionsCollapsed extends StatelessWidget {
  final VoidCallback onImport;
  final VoidCallback onExport;

  const NavigationRailActionsCollapsed({
    super.key,
    required this.onImport,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onImport,
          icon: const Icon(Icons.file_upload),
          tooltip: 'Import',
        ),
        IconButton(
          onPressed: onExport,
          icon: const Icon(Icons.file_download),
          tooltip: 'Export',
        ),
      ],
    );
  }
}

/// Navigation rail action buttons (Import/Export)
class NavigationRailActions extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onImport;
  final VoidCallback onExport;

  const NavigationRailActions({
    super.key,
    required this.isExpanded,
    required this.onImport,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return NavigationRailActionsExpanded(
        onImport: onImport,
        onExport: onExport,
      );
    }

    return NavigationRailActionsCollapsed(
      onImport: onImport,
      onExport: onExport,
    );
  }
}
