import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../screens/home_screen.dart';

/// Provider for the GoRouter instance
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          // Handle config parameter from URL
          // Try state.uri first, fallback to Uri.base for web
          final configParam = state.uri.queryParameters['config'] ?? 
                             (kIsWeb ? Uri.base.queryParameters['config'] : null);
          
          return HomeScreen(
            configParam: configParam,
          );
        },
      ),
    ],
    
    // Optional: Error page for invalid routes
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found: ${state.uri.path}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

/// Extension for easy navigation with go_router
extension GoRouterExtension on BuildContext {
  /// Navigate to home with optional config parameter
  void goHome({String? config}) {
    if (config != null && config.isNotEmpty) {
      go('/?config=$config');
    } else {
      go('/');
    }
  }
  
  /// Generate a shareable URL with config parameter
  String generateShareUrl(String base64Config) {
    // Get the current base URL
    final router = GoRouter.of(this);
    final location = router.namedLocation('home', 
      queryParameters: {'config': base64Config});
    
    // For web, prepend the origin
    // For mobile, this would be the deep link scheme
    return location;
  }
}
