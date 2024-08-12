import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/language_evolution_controller.dart';

class PredictiveLanguageEvolution extends ConsumerStatefulWidget {
  const PredictiveLanguageEvolution({super.key});

  @override
  ConsumerState<PredictiveLanguageEvolution> createState() =>
      _PredictiveLanguageEvolutionState();
}

class _PredictiveLanguageEvolutionState
    extends ConsumerState<PredictiveLanguageEvolution> {
  final TextEditingController _wordController = TextEditingController();
  int _yearsFuture = 50;

  @override
  Widget build(BuildContext context) {
    final evolvedLanguage = ref.watch(languageEvolutionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Predictive Language Evolution')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _wordController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a word or phrase',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Years into the future: $_yearsFuture'),
                Slider(
                  min: 10,
                  max: 200,
                  divisions: 19,
                  label: _yearsFuture.toString(),
                  value: _yearsFuture.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      _yearsFuture = value.round();
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(languageEvolutionProvider.notifier)
                        .evolveLanguage(_wordController.text, _yearsFuture);
                  },
                  child: const Text('Evolve Language'),
                ),
                const SizedBox(height: 16),
                const Text('Evolved language:'),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: MarkdownBody(
                    data: evolvedLanguage,
                    styleSheet: MarkdownStyleSheet(
                      h1: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                        fontFamily: 'Roboto', // Font to be specified
                        decoration: TextDecoration.underline,
                      ),
                      p: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        letterSpacing: 1.2, // Adjust letter spacing
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
