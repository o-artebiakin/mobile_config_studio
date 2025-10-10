import 'dart:convert';

import '../../providers/config_provider.dart';

/// Service for exporting configuration data in various formats
class ConfigExportService {
  /// Convert ConfigState to JSON map
  Map<String, dynamic> toJson(ConfigState state) {
    return state.toJsonExport();
  }

  /// Convert ConfigState to JSON string
  String toJsonString(ConfigState state, {bool pretty = false}) {
    final json = toJson(state);
    if (pretty) {
      return const JsonEncoder.withIndent('  ').convert(json);
    }
    return jsonEncode(json);
  }

  /// Convert ConfigState to base64-encoded JSON
  String toBase64(ConfigState state) {
    final jsonString = toJsonString(state);
    final bytes = utf8.encode(jsonString);
    return base64Encode(bytes);
  }

  /// Generate a shareable URL with base64 config
  String toShareUrl(ConfigState state, {required String baseUrl}) {
    final base64Config = toBase64(state);
    return '$baseUrl?config=$base64Config';
  }

  /// Generate Flutter run command with config
  String toFlutterCommand(
    ConfigState state, {
    String? target,
    String? flavor,
    bool separateDefines = false,
  }) {
    final buffer = StringBuffer('flutter run');

    if (target != null) {
      buffer.write(' -d $target');
    }

    if (flavor != null) {
      buffer.write(' --flavor $flavor');
    }

    if (separateDefines) {
      // Generate separate --dart-define for each key
      final selectedFlavor = state.flavors.firstWhere(
        (f) => f.name == flavor,
        orElse: () => state.flavors.first,
      );
      
      for (final group in selectedFlavor.groups) {
        for (final key in group.keys) {
          buffer.write(' --dart-define=${key.key}=${key.value}');
        }
      }
    } else {
      // Use base64 encoded config
      final base64Config = toBase64(state);
      buffer.write(' --dart-define=CONFIG_DATA=$base64Config');
    }

    return buffer.toString();
  }
}
