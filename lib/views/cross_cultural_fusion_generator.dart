import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/cultural_fusion_controller.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CrossCulturalFusionGenerator extends ConsumerStatefulWidget {
  const CrossCulturalFusionGenerator({super.key});

  @override
  ConsumerState<CrossCulturalFusionGenerator> createState() =>
      _CrossCulturalFusionGeneratorState();
}

class _CrossCulturalFusionGeneratorState
    extends ConsumerState<CrossCulturalFusionGenerator> {
  double _fusionLevel = 0.5;

  @override
  Widget build(BuildContext context) {
    final fusionDescription = ref.watch(culturalFusionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Cross-Cultural Fusion Generator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Fusion Level: ${(_fusionLevel * 100).round()}%'),
            Slider(
              value: _fusionLevel,
              onChanged: (value) {
                setState(() {
                  _fusionLevel = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => ref
                  .read(culturalFusionProvider.notifier)
                  .generateFusion(_fusionLevel),
              child: const Text('Generate Fusion'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: fusionDescription,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
