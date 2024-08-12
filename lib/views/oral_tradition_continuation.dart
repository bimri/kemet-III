import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/oral_tradition_controller.dart';

class OralTraditionContinuation extends ConsumerStatefulWidget {
  const OralTraditionContinuation({super.key});

  @override
  ConsumerState<OralTraditionContinuation> createState() =>
      _OralTraditionContinuationState();
}

class _OralTraditionContinuationState
    extends ConsumerState<OralTraditionContinuation> {
  final TextEditingController _promptController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final generatedStory = ref.watch(oralTraditionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Oral Tradition Continuation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _promptController,
              decoration: const InputDecoration(
                labelText: 'Enter the beginning of a traditional story',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref
                  .read(oralTraditionProvider.notifier)
                  .generateStory(_promptController.text),
              child: const Text('Generate Continuation'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: MarkdownBody(data: generatedStory),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
