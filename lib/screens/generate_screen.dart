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
import '../widgets/generate/command_line_tab.dart';
import '../widgets/generate/documentation_tab.dart';
import '../widgets/generate/export_tab.dart';
import '../widgets/generate/ide_configs_tab.dart';

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
    final androidStudioFiles = useState<Map<String, String>>({});

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
      final androidStudioFilesMap = androidStudioGen.generateAllFiles(state);

      jsonOutput.value = jsonString;
      base64Output.value = base64String;
      commandLineOutput.value = commandLine;
      confluenceOutput.value = confluence;
      vscodeConfigOutput.value = vscodeConfig;
      androidStudioFiles.value = androidStudioFilesMap;

      return null;
    }, [state, selectedCommand.value, selectedFlavor.value, usePlaceholders.value]);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Configuration'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.file_download), text: 'Export'),
              Tab(icon: Icon(Icons.terminal), text: 'Command Line'),
              Tab(icon: Icon(Icons.code), text: 'IDE Configs'),
              Tab(icon: Icon(Icons.description), text: 'Documentation'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Export Tab
            ExportTab(
              jsonOutput: jsonOutput.value,
              base64Output: base64Output.value,
            ),

            // Command Line Tab
            CommandLineTab(
              state: state,
              selectedCommand: selectedCommand,
              selectedFlavor: selectedFlavor,
              usePlaceholders: usePlaceholders,
              commandLineOutput: commandLineOutput.value,
            ),

            // IDE Configs Tab
            IdeConfigsTab(
              state: state,
              vscodeConfigOutput: vscodeConfigOutput.value,
              androidStudioFiles: androidStudioFiles.value,
              selectedFlavor: selectedFlavor,
            ),

            // Documentation Tab
            DocumentationTab(
              confluenceOutput: confluenceOutput.value,
            ),
          ],
        ),
      ),
    );
  }
}
