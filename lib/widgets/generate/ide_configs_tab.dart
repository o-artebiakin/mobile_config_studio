import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../providers/config_provider.dart';
import '../../utils/clipboard_helper.dart';
import 'output_section.dart';

class IdeConfigsTab extends HookWidget {
  final ConfigState state;
  final String vscodeConfigOutput;
  final Map<String, String> androidStudioFiles;
  final ValueNotifier<String?> selectedFlavor;

  const IdeConfigsTab({
    super.key,
    required this.state,
    required this.vscodeConfigOutput,
    required this.androidStudioFiles,
    required this.selectedFlavor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // VS Code Section
        OutputSection(
          title: 'VS Code Launch Configuration',
          content: vscodeConfigOutput,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            vscodeConfigOutput,
            'VS Code config copied to clipboard',
          ),
          subtitle: 'Add this to .vscode/launch.json in your Flutter project',
        ),
        const SizedBox(height: 24),

        // Android Studio Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and download all button
            Row(
              children: [
                Text(
                  'Android Studio Run Configuration',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                ElevatedButton.icon(
                  icon: const Icon(Icons.download),
                  label: const Text('Download All as ZIP'),
                  onPressed: androidStudioFiles.isNotEmpty
                      ? () => ClipboardHelper.downloadRunConfigurations(
                            context,
                            androidStudioFiles,
                          )
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Flavor selector and copy button
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Select Flavor:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 12),
                        DropdownButton<String>(
                          value: selectedFlavor.value,
                          items: state.flavors
                              .map((f) => DropdownMenuItem(
                                    value: f.name,
                                    child: Text(f.name),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            selectedFlavor.value = value;
                          },
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          tooltip: 'Copy config for selected flavor',
                          onPressed: androidStudioFiles['Flutter (${selectedFlavor.value}).run.xml'] != null
                              ? () => ClipboardHelper.copyToClipboard(
                                    context,
                                    androidStudioFiles['Flutter (${selectedFlavor.value}).run.xml']!,
                                    'Config for ${selectedFlavor.value} copied!',
                                  )
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'File: .run/Flutter (${selectedFlavor.value}).run.xml',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
                        ),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SelectableText(
                          androidStudioFiles['Flutter (${selectedFlavor.value}).run.xml'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a flavor to preview its configuration. Copy the selected flavor\'s config or download all flavors as a ZIP archive.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
