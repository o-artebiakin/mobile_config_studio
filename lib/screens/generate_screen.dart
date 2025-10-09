import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/config_provider.dart';
import '../services/config_export_service.dart';
import '../services/generators/android_studio_config_generator.dart';
import '../services/generators/command_line_generator.dart';
import '../services/generators/confluence_doc_generator.dart';
import '../services/generators/vscode_config_generator.dart';
import '../utils/clipboard_helper.dart';
import '../widgets/generate/command_controls_section.dart';
import '../widgets/generate/output_section.dart';

class GenerateScreen extends HookConsumerWidget {
  const GenerateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(configProvider);
    final exportService = ConfigExportService();
    final commandLineGen = CommandLineGenerator();
    final confluenceGen = ConfluenceDocGenerator();
    final vscodeGen = VSCodeConfigGenerator();
    final androidStudioGen = AndroidStudioConfigGenerator();

    final jsonOutput = useState<String>('');
    final base64Output = useState<String>('');
    final commandLineOutput = useState<String>('');
    final confluenceOutput = useState<String>('');
    final vscodeConfigOutput = useState<String>('');
    final androidStudioConfigOutput = useState<String>('');
    
    // Command configuration
    final selectedCommand = useState<String>('run'); // 'run' or 'build'
    final selectedFlavor = useState<String?>(
      state.flavors.isNotEmpty ? state.flavors.first.name : null,
    );
    final usePlaceholders = useState<bool>(false);

    useEffect(() {
      // Generate outputs when screen loads or command options change
      final json = exportService.toJson(state);
      final jsonString = const JsonEncoder.withIndent('  ').convert(json);
      final base64String = exportService.toBase64(state);
      final commandLine = commandLineGen.generate(
        base64String,
        state: state,
        command: selectedCommand.value,
        flavor: selectedFlavor.value,
        usePlaceholders: usePlaceholders.value,
      );
      final confluence = confluenceGen.generate(state);
      final vscodeConfig = vscodeGen.generate(state);
      final androidStudioConfig = androidStudioGen.generate(state);

      jsonOutput.value = jsonString;
      base64Output.value = base64String;
      commandLineOutput.value = commandLine;
      confluenceOutput.value = confluence;
      vscodeConfigOutput.value = vscodeConfig;
      androidStudioConfigOutput.value = androidStudioConfig;

      return null;
    }, [state, selectedCommand.value, selectedFlavor.value, usePlaceholders.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate Configuration'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          OutputSection(
            title: 'JSON Configuration',
            content: jsonOutput.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              jsonOutput.value,
              'JSON copied to clipboard',
            ),
            onDownload: () => ClipboardHelper.downloadJson(context, jsonOutput.value),
          ),
          const SizedBox(height: 24),
          OutputSection(
            title: 'Base64 Encoded',
            content: base64Output.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              base64Output.value,
              'Base64 copied to clipboard',
            ),
          ),
          const SizedBox(height: 24),
          OutputSection(
            title: 'Flutter Command Line',
            content: commandLineOutput.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              commandLineOutput.value,
              'Command copied to clipboard',
            ),
            subtitle:
                'Run this command to launch your Flutter app with this configuration',
            extraControls: CommandControlsSection(
              selectedCommand: selectedCommand,
              selectedFlavor: selectedFlavor,
              usePlaceholders: usePlaceholders,
              availableFlavors: state.flavors.map((f) => f.name).toList(),
            ),
          ),
          const SizedBox(height: 24),
          OutputSection(
            title: 'Confluence Documentation',
            content: confluenceOutput.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              confluenceOutput.value,
              'Confluence markup copied to clipboard',
            ),
            subtitle:
                'Copy and paste this into Confluence for documentation',
          ),
          const SizedBox(height: 24),
          OutputSection(
            title: 'VS Code Launch Configuration',
            content: vscodeConfigOutput.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              vscodeConfigOutput.value,
              'VS Code config copied to clipboard',
            ),
            subtitle:
                'Add this to .vscode/launch.json in your Flutter project',
          ),
          const SizedBox(height: 24),
          OutputSection(
            title: 'Android Studio Run Configuration',
            content: androidStudioConfigOutput.value,
            onCopy: () => ClipboardHelper.copyToClipboard(
              context,
              androidStudioConfigOutput.value,
              'Android Studio config copied to clipboard',
            ),
            subtitle:
                'Use this as reference for Android Studio run configurations',
          ),
        ],
      ),
    );
  }
}
