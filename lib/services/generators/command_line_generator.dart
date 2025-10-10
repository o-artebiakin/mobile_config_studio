import '../../models/config_flavor.dart';
import '../../providers/config_provider.dart';

class CommandLineGenerator {
  String generate(
    String base64Config, {
    required ConfigState state,
    required String command,
    String? flavor,
    required bool usePlaceholders,
  }) {
    final buffer = StringBuffer();

    if (command == 'build') {
      buffer.write('flutter build apk'); // or 'web', 'ios', etc.
    } else {
      buffer.write('flutter run');
    }

    if (flavor != null && flavor.isNotEmpty) {
      buffer.write(' --flavor $flavor');
    }

    // Always use separate --dart-define for each key
    if (flavor != null) {
      final selectedFlavor = state.flavors.firstWhere(
        (f) => f.name == flavor,
        orElse: () => state.flavors.isNotEmpty
            ? state.flavors.first
            : ConfigFlavor(name: '', groups: [], createdAt: DateTime(0), updatedAt: DateTime(0)),
      );

      for (final group in selectedFlavor.groups) {
        for (final key in group.keys) {
          final value = usePlaceholders ? '<value>' : key.value;
          final formattedKey = _formatKey(group.name, key.key);
          buffer.write(' --dart-define=$formattedKey=$value');
        }
      }
    } else {
      // No flavor selected, show message
      buffer.write(' # Select a flavor to see --dart-define parameters');
    }

    return buffer.toString();
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
