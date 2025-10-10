import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../providers/config_provider.dart';
import '../../utils/clipboard_helper.dart';
import 'command_controls_section.dart';
import 'output_section.dart';

class CommandLineTab extends HookWidget {
  final ConfigState state;
  final ValueNotifier<String> selectedCommand;
  final ValueNotifier<String?> selectedFlavor;
  final ValueNotifier<bool> usePlaceholders;
  final String commandLineOutput;
  final String envDartOutput;

  const CommandLineTab({
    super.key,
    required this.state,
    required this.selectedCommand,
    required this.selectedFlavor,
    required this.usePlaceholders,
    required this.commandLineOutput,
    required this.envDartOutput,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OutputSection(
          title: 'Flutter Command Line',
          content: commandLineOutput,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            commandLineOutput,
            'Command copied to clipboard',
          ),
          subtitle: 'Run this command to launch your Flutter app with this configuration',
          extraControls: CommandControlsSection(
            selectedCommand: selectedCommand,
            selectedFlavor: selectedFlavor,
            usePlaceholders: usePlaceholders,
            availableFlavors: state.flavors.map((f) => f.name).toList(),
          ),
        ),
        const SizedBox(height: 24),
        OutputSection(
          title: 'Env Dart File (env.dart)',
          content: envDartOutput,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            envDartOutput,
            'Env Dart file copied to clipboard',
          ),
          subtitle: 'Save as lib/env.dart - Uses String.fromEnvironment for compile-time configuration',
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'How to use Env file',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '1. Copy the env.dart code above',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '2. Create file: lib/env.dart and paste the code',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '3. Use the command line above with --dart-define parameters',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                const Divider(),
                const SizedBox(height: 12),
                Text(
                  'Usage in your code:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    'import \'package:your_app/env.dart\';\n\nvoid main() {\n  print(Env.networkApiUrl);\n  print(Env.auth0Audience);\n}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: 'monospace',
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
