import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/language_evolution_controller.dart';
import '../widgets/kemet_app_bar.dart';
import '../widgets/kemet_title.dart';
import '../widgets/kemet_body_text.dart';
import '../widgets/kemet_button_text.dart';

class PredictiveLanguageEvolution extends ConsumerStatefulWidget {
  const PredictiveLanguageEvolution({super.key});

  @override
  ConsumerState<PredictiveLanguageEvolution> createState() =>
      _PredictiveLanguageEvolutionState();
}

class _PredictiveLanguageEvolutionState
    extends ConsumerState<PredictiveLanguageEvolution>
    with SingleTickerProviderStateMixin {
  final TextEditingController _wordController = TextEditingController();
  int _yearsFuture = 50;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final evolvedLanguage = ref.watch(languageEvolutionProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const KemetAppBar(title: 'Predictive Language Evolution'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/predictive-lang.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.5),
                      end: Offset.zero,
                    ).animate(_animation),
                    child: _buildInputSection(),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(_animation),
                    child: _buildOutputSection(evolvedLanguage),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _wordController,
              decoration: InputDecoration(
                labelText: 'Enter a word or phrase',
                hintText: 'Try in Swahili or any local language',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            KemetBodyText(
              text: 'Years into the future: $_yearsFuture',
              fontSize: 16,
            ),
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
              child: KemetButtonText(text: 'Evolve Language'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputSection(String evolvedLanguage) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KemetTitle(
              text: 'Evolved language:',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            MarkdownBody(
              data: evolvedLanguage,
              styleSheet: MarkdownStyleSheet(
                p: GoogleFonts.lato(fontSize: 16),
                h1: GoogleFonts.raleway(
                    fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
