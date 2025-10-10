import '../../models/config_flavor.dart';
import '../../providers/config_provider.dart';

class AndroidStudioConfigGenerator {
  /// Generate a single .run.xml file for a specific flavor
  String generateRunXml(ConfigFlavor flavor) {
    final buffer = StringBuffer();
    
    // XML header
    buffer.writeln('<component name="ProjectRunConfigurationManager">');
    buffer.writeln('  <configuration default="false" name="Flutter (${flavor.name})" type="FlutterRunConfigurationType" factoryName="Flutter">');
    
    // Build additionalArgs string
    final dartDefines = <String>[];
    for (final group in flavor.groups) {
      for (final key in group.keys) {
        final formattedKey = _formatKey(group.name, key.key);
        dartDefines.add('--dart-define=$formattedKey=${key.value}');
      }
    }
    
    if (dartDefines.isNotEmpty) {
      buffer.writeln('    <option name="additionalArgs" value="${dartDefines.join(' ')}" />');
    }
    
    // Build flavor (exact name)
    buffer.writeln('    <option name="buildFlavor" value="${flavor.name}" />');
    
    // File path
    buffer.writeln('    <option name="filePath" value="\$PROJECT_DIR\$/lib/main.dart" />');
    
    // Close configuration
    buffer.writeln('    <method v="2" />');
    buffer.writeln('  </configuration>');
    buffer.writeln('</component>');
    
    return buffer.toString();
  }

  /// Generate instructions for all flavors (legacy format)
  String generate(ConfigState state) {
    final buffer = StringBuffer();

    buffer.writeln('# Android Studio Run Configurations (.run.xml files)');
    buffer.writeln('');
    buffer.writeln('Copy the XML content below for each flavor to:');
    buffer.writeln('`.run/Flutter (FlavorName).run.xml`');
    buffer.writeln('');
    buffer.writeln('---');
    buffer.writeln('');

    for (final flavor in state.flavors) {
      buffer.writeln('## Flutter (${flavor.name}).run.xml');
      buffer.writeln('');
      buffer.writeln('```xml');
      buffer.write(generateRunXml(flavor));
      buffer.writeln('```');
      buffer.writeln('');
      buffer.writeln('---');
      buffer.writeln('');
    }

    return buffer.toString();
  }

  /// Generate a map of filename -> content for all flavors
  /// Useful for downloading as separate files
  Map<String, String> generateAllFiles(ConfigState state) {
    final files = <String, String>{};
    
    for (final flavor in state.flavors) {
      final filename = 'Flutter (${flavor.name}).run.xml';
      files[filename] = generateRunXml(flavor);
    }
    
    return files;
  }

  /// Generate a single downloadable file with instructions
  String generateDownloadableInstructions(ConfigState state) {
    final buffer = StringBuffer();
    
    buffer.writeln('═══════════════════════════════════════════════════════════');
    buffer.writeln('Android Studio Run Configurations - Setup Instructions');
    buffer.writeln('═══════════════════════════════════════════════════════════');
    buffer.writeln('');
    buffer.writeln('STEP 1: Create the .run folder');
    buffer.writeln('  - In your project root, create a folder named: .run');
    buffer.writeln('  - This folder will contain all run configurations');
    buffer.writeln('');
    buffer.writeln('STEP 2: Create individual XML files');
    buffer.writeln('  - Copy each configuration below to its respective file');
    buffer.writeln('  - File names are specified in the headers');
    buffer.writeln('');
    buffer.writeln('STEP 3: Restart Android Studio');
    buffer.writeln('  - Configurations will appear in the run dropdown');
    buffer.writeln('');
    buffer.writeln('═══════════════════════════════════════════════════════════');
    buffer.writeln('');
    
    for (final flavor in state.flavors) {
      final filename = 'Flutter (${flavor.name}).run.xml';
      buffer.writeln('');
      buffer.writeln('┌─────────────────────────────────────────────────────────┐');
      buffer.writeln('│ FILE: .run/$filename');
      buffer.writeln('└─────────────────────────────────────────────────────────┘');
      buffer.writeln('');
      buffer.writeln(generateRunXml(flavor));
      buffer.writeln('');
      buffer.writeln('─────────────────────────────────────────────────────────');
      buffer.writeln('');
    }
    
    buffer.writeln('');
    buffer.writeln('═══════════════════════════════════════════════════════════');
    buffer.writeln('End of Configurations');
    buffer.writeln('═══════════════════════════════════════════════════════════');
    
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
