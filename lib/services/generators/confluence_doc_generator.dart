import 'package:flutter/foundation.dart';

import '../../providers/config_provider.dart';
import '../../services/config_export_service.dart';

class ConfluenceDocGenerator {
  String generate(ConfigState state) {
    final buffer = StringBuffer();
    
    // Title and metadata
    buffer.writeln('h1. Mobile App Configuration Documentation');
    buffer.writeln('');
    buffer.writeln('*Last Updated:* ${DateTime.now().toString().split('.')[0]}');
    buffer.writeln('*Total Flavors:* ${state.flavors.length}');
    buffer.writeln('');
    
    // Import link section
    final base64Config = ConfigExportService().toBase64(state);
    final importUrl = kIsWeb 
        ? '${Uri.base.origin}${Uri.base.path}?config=$base64Config'
        : 'https://your-app-url.com/?config=$base64Config';
    
    buffer.writeln('h2. Quick Import');
    buffer.writeln('');
    buffer.writeln('{info}');
    buffer.writeln('Click the link below to import this configuration into Config Studio:');
    buffer.writeln('[Open in Config Studio|$importUrl]');
    buffer.writeln('{info}');
    buffer.writeln('');
    
    // Configuration overview table
    buffer.writeln('h2. Configuration Overview');
    buffer.writeln('');
    
    for (final flavor in state.flavors) {
      buffer.writeln('h3. Flavor: ${flavor.name}');
      buffer.writeln('');
      
      for (final group in flavor.groups) {
        buffer.writeln('h4. ${group.name}');
        buffer.writeln('');
        
        // Table header
        buffer.writeln('||Key||Value||Description||');
        
        // Table rows
        for (final key in group.keys) {
          // Escape pipe characters in values
          final escapedValue = key.value.replaceAll('|', '\\|');
          buffer.writeln('|${key.key}|{code}$escapedValue{code}|_Add description here_|');
        }
        
        buffer.writeln('');
      }
    }
    
    // Flutter command section
    buffer.writeln('h2. Flutter Commands');
    buffer.writeln('');
    
    for (final flavor in state.flavors) {
      buffer.writeln('h3. Run with ${flavor.name}');
      buffer.writeln('');
      buffer.writeln('{code:bash}');
      
      final commandBuffer = StringBuffer('flutter run --flavor ${flavor.name.toLowerCase()}');
      
      for (final group in flavor.groups) {
        for (final key in group.keys) {
          commandBuffer.write(' \\\\\n  --dart-define=${key.key}=${key.value}');
        }
      }
      
      buffer.writeln(commandBuffer.toString());
      buffer.writeln('{code}');
      buffer.writeln('');
    }
    
    // Security note
    buffer.writeln('h2. Security Notes');
    buffer.writeln('');
    buffer.writeln('{warning}');
    buffer.writeln('*Important:* This documentation contains sensitive configuration data.');
    buffer.writeln('');
    buffer.writeln('* Restrict access to authorized personnel only');
    buffer.writeln('* Do not commit actual values to public repositories');
    buffer.writeln('* Use environment variables or secure vaults for production secrets');
    buffer.writeln('* Regularly rotate sensitive credentials (API keys, tokens, etc.)');
    buffer.writeln('{warning}');
    buffer.writeln('');
    
    // Base64 storage (for backup)
    buffer.writeln('h2. Configuration Backup');
    buffer.writeln('');
    buffer.writeln('{tip}');
    buffer.writeln('The complete configuration is stored in base64 format below for backup purposes:');
    buffer.writeln('{tip}');
    buffer.writeln('');
    buffer.writeln('{code:title=Base64 Configuration}');
    buffer.writeln(base64Config);
    buffer.writeln('{code}');
    
    return buffer.toString();
  }
}
