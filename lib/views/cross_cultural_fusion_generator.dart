import 'package:flutter/material.dart';
import '../widgets/kemet_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../controllers/cultural_fusion_controller.dart';
import '../widgets/kemet_title.dart';
import '../widgets/kemet_body_text.dart';
import '../widgets/kemet_button_text.dart';

class CrossCulturalFusionGenerator extends ConsumerStatefulWidget {
  const CrossCulturalFusionGenerator({super.key});

  @override
  ConsumerState<CrossCulturalFusionGenerator> createState() =>
      _CrossCulturalFusionGeneratorState();
}

class _CrossCulturalFusionGeneratorState
    extends ConsumerState<CrossCulturalFusionGenerator>
    with SingleTickerProviderStateMixin {
  double _fusionLevel = 0.5;
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
    final fusionDescription = ref.watch(culturalFusionProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const KemetAppBar(title: 'Cross-Cultural Fusion'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/x-cultural.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                    child: _buildOutputSection(fusionDescription),
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
            KemetBodyText(
              text: 'Fusion Level: ${(_fusionLevel * 100).round()}%',
              fontSize: 18,
            ),
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
              child: KemetButtonText(text: 'Generate Fusion'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputSection(String fusionDescription) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            KemetTitle(
              text: 'Cultural Fusion:',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            MarkdownBody(
              data: fusionDescription,
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
