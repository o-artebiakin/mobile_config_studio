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
      buffer.write(' --flavor ${flavor.toLowerCase()}');
    }

    // Always use separate --dart-define for each key
    if (flavor != null) {
      final selectedFlavor = state.flavors.firstWhere(
        (f) => f.name == flavor,
        orElse: () => state.flavors.isNotEmpty
            ? state.flavors.first
            : ConfigFlavor(name: '', groups: []),
      );

      for (final group in selectedFlavor.groups) {
        for (final key in group.keys) {
          final value = usePlaceholders ? '<value>' : key.value;
          buffer.write(' --dart-define=${key.key}=$value');
        }
      }
    } else {
      // No flavor selected, show message
      buffer.write(' # Select a flavor to see --dart-define parameters');
    }

    return buffer.toString();
  }
}
