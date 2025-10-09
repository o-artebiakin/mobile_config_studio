import 'package:flutter/material.dart';

/// Expanded app header for the navigation rail
class NavigationRailHeaderExpanded extends StatelessWidget {
  const NavigationRailHeaderExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Icon(
            Icons.settings_applications,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Config Studio',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }
}

/// Collapsed app header for the navigation rail
class NavigationRailHeaderCollapsed extends StatelessWidget {
  const NavigationRailHeaderCollapsed({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Icon(
        Icons.settings_applications,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
    );
  }
}

/// App header for the navigation rail
class NavigationRailHeader extends StatelessWidget {
  final bool isExpanded;

  const NavigationRailHeader({super.key, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return const NavigationRailHeaderExpanded();
    }

    return const NavigationRailHeaderCollapsed();
  }
}
