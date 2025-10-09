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
          toolArgs.add('--dart-define=${key.key}=${key.value}');
        }
      }

      configurations.add({
        'name': 'Flutter (${flavor.name})',
        'request': 'launch',
        'type': 'dart',
        'program': 'lib/main.dart',
        'args': [
          '--flavor',
          flavor.name.toLowerCase(),
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
