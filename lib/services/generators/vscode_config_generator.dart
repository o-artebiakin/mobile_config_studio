import 'dart:convert';

import '../../providers/config_provider.dart';
import '../../utils/key_formatter.dart';

class VSCodeConfigGenerator {
  String generate(ConfigState state) {
    final configurations = <Map<String, dynamic>>[];

    for (final flavor in state.flavors) {
      // Collect all dart-define arguments
      final toolArgs = <String>[];
      for (final group in flavor.groups) {
        for (final key in group.keys) {
          final formattedKey = KeyFormatter.formatKey(group.name, key.key);
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
}
