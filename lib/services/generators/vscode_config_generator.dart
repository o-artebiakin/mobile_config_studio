import 'dart:convert';

import '../../providers/config_provider.dart';

class VSCodeConfigGenerator {
  String generate(ConfigState state) {
    final configurations = <Map<String, dynamic>>[];

    for (final flavor in state.flavors) {
      // Collect all dart-define arguments
      final toolArgs = <String>[];
      for (final group in flavor.groups) {
        for (final key in group.keys) {
          final formattedKey = _formatKey(group.name, key.key);
          toolArgs.add('--dart-define=$formattedKey=${key.value}');
        }
      }

      configurations.add({
        'name': 'Flutter (${flavor.name})',
        'request': 'launch',
        'type': 'dart',
        'program': 'lib/main.dart',
        'args': [
          '--flavor',
          flavor.name,
          ...toolArgs,
        ],
      });
    }

    final launchJson = {
      'version': '0.2.0',
      'configurations': configurations,
    };

    return const JsonEncoder.withIndent('  ').convert(launchJson);
  }

  /// Formats the key as uppercase snake case with group name prefix
  /// Example: group="Auth0", key="audience" -> "AUTH0_AUDIENCE"
  String _formatKey(String groupName, String keyName) {
    final formattedGroup = _toSnakeCase(groupName).toUpperCase();
    final formattedKey = _toSnakeCase(keyName).toUpperCase();
    return '${formattedGroup}_$formattedKey';
  }

  /// Converts a string to snake_case
  String _toSnakeCase(String input) {
    // Replace spaces and hyphens with underscores
    String result = input.replaceAll(RegExp(r'[\s-]+'), '_');
    
    // Insert underscore before capital letters (for camelCase)
    result = result.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)}',
    );
    
    // Remove any duplicate underscores
    result = result.replaceAll(RegExp(r'_+'), '_');
    
    // Remove leading/trailing underscores
    result = result.replaceAll(RegExp(r'^_+|_+$'), '');
    
    return result;
  }
}
