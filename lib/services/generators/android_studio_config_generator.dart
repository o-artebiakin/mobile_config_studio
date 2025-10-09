import '../../providers/config_provider.dart';

class AndroidStudioConfigGenerator {
  String generate(ConfigState state) {
    final buffer = StringBuffer();

    buffer.writeln('# Android Studio Run Configurations');
    buffer.writeln('');
    buffer.writeln('To create run configurations in Android Studio:');
    buffer.writeln('');
    buffer.writeln('1. Go to Run > Edit Configurations...');
    buffer.writeln('2. Click "+" and select "Flutter"');
    buffer.writeln('3. Configure as follows:');
    buffer.writeln('');

    for (final flavor in state.flavors) {
      buffer.writeln('## Configuration: ${flavor.name}');
      buffer.writeln('');
      buffer.writeln('**Name:** Flutter (${flavor.name})');
      buffer.writeln('**Dart entrypoint:** lib/main.dart');
      buffer.writeln('**Build flavor:** ${flavor.name.toLowerCase()}');
      buffer.writeln('');
      buffer.writeln('**Additional run args:**');
      buffer.writeln('```');

      for (final group in flavor.groups) {
        for (final key in group.keys) {
          buffer.writeln('--dart-define=${key.key}=${key.value}');
        }
      }

      buffer.writeln('```');
      buffer.writeln('');
      buffer.writeln('---');
      buffer.writeln('');
    }

    buffer.writeln('## Alternative: Command Line');
    buffer.writeln('');
    buffer.writeln('You can also run directly from the terminal:');
    buffer.writeln('');

    for (final flavor in state.flavors) {
      buffer.writeln('### ${flavor.name}:');
      buffer.writeln('```bash');
      buffer.write('flutter run --flavor ${flavor.name.toLowerCase()}');

      for (final group in flavor.groups) {
        for (final key in group.keys) {
          buffer.write(' \\\n  --dart-define=${key.key}=${key.value}');
        }
      }

      buffer.writeln('');
      buffer.writeln('```');
      buffer.writeln('');
    }

    return buffer.toString();
  }
}
