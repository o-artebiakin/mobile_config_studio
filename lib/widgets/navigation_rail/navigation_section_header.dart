import 'package:flutter/material.dart';

/// Expanded header for a navigation section (Flavors or Groups)
class NavigationSectionHeaderExpanded extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback? onAdd;

  const NavigationSectionHeaderExpanded({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).colorScheme.onInverseSurface,
      child: ListTile(
        dense: true,
        leading: Icon(
          isExpanded ? Icons.expand_more : Icons.chevron_right,
          size: 20,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          maxLines: 1,
          overflow: TextOverflow.fade,
        ),
        trailing: onAdd != null
            ? IconButton(
                icon: const Icon(Icons.add, size: 18),
                tooltip: 'Add $title',
                onPressed: onAdd,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              )
            : null,
        onTap: onToggle,
      ),
    );
  }
}

/// Collapsed header for a navigation section (Flavors or Groups)
class NavigationSectionHeaderCollapsed extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onToggle;

  const NavigationSectionHeaderCollapsed({
    super.key,
    required this.title,
    required this.icon,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: title,
      child: InkWell(
        onTap: onToggle,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Header for a navigation section (Flavors or Groups)
class NavigationSectionHeader extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final bool isCollapsed;
  final VoidCallback onToggle;
  final VoidCallback? onAdd;
  final IconData collapsedIcon;

  const NavigationSectionHeader({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.isCollapsed,
    required this.onToggle,
    required this.collapsedIcon,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    if (isCollapsed) {
      return NavigationSectionHeaderCollapsed(
        title: title,
        icon: collapsedIcon,
        onToggle: onToggle,
      );
    }
    
    return NavigationSectionHeaderExpanded(
      title: title,
      isExpanded: isExpanded,
      onToggle: onToggle,
      onAdd: onAdd,
    );
  }
}
