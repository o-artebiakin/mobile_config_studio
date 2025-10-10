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

  const CommandLineTab({
    super.key,
    required this.state,
    required this.selectedCommand,
    required this.selectedFlavor,
    required this.usePlaceholders,
    required this.commandLineOutput,
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
      ],
    );
  }
}
