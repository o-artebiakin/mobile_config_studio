import 'package:flutter/material.dart';

/// Expanded navigation rail action buttons (Import/Export/Generate)
class NavigationRailActionsExpanded extends StatelessWidget {
  final VoidCallback onImport;
  final VoidCallback onExport;
  final VoidCallback onGenerate;

  const NavigationRailActionsExpanded({
    super.key,
    required this.onImport,
    required this.onExport,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onGenerate,
              icon: const Icon(Icons.code, size: 18),
              label: const Text('Generate'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Collapsed navigation rail action buttons (Import/Export/Generate)
class NavigationRailActionsCollapsed extends StatelessWidget {
  final VoidCallback onImport;
  final VoidCallback onExport;
  final VoidCallback onGenerate;

  const NavigationRailActionsCollapsed({
    super.key,
    required this.onImport,
    required this.onExport,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(height: 4),
        IconButton(
          onPressed: onGenerate,
          icon: const Icon(Icons.code),
          tooltip: 'Generate',
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

/// Navigation rail action buttons (Import/Export/Generate)
class NavigationRailActions extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onImport;
  final VoidCallback onExport;
  final VoidCallback onGenerate;

  const NavigationRailActions({
    super.key,
    required this.isExpanded,
    required this.onImport,
    required this.onExport,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return NavigationRailActionsExpanded(
        onImport: onImport,
        onExport: onExport,
        onGenerate: onGenerate,
      );
    }

    return NavigationRailActionsCollapsed(
      onImport: onImport,
      onExport: onExport,
      onGenerate: onGenerate,
    );
  }
}
