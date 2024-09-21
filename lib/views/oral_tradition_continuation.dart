import 'package:flutter/material.dart';
import '../widgets/kemet_app_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/oral_tradition_controller.dart';

class OralTraditionContinuation extends ConsumerStatefulWidget {
  const OralTraditionContinuation({super.key});

  @override
  ConsumerState<OralTraditionContinuation> createState() =>
      _OralTraditionContinuationState();
}

class _OralTraditionContinuationState
    extends ConsumerState<OralTraditionContinuation>
    with SingleTickerProviderStateMixin {
  final TextEditingController _promptController = TextEditingController();
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
    final generatedStory = ref.watch(oralTraditionProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const KemetAppBar(title: 'Oral Tradition Continuation'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bmr.jpg'),
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
                    child: _buildOutputSection(generatedStory),
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
              controller: _promptController,
              decoration: InputDecoration(
                labelText: 'Enter the beginning of a traditional story',
                hintText: 'Use any local or foreign language',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref
                  .read(oralTraditionProvider.notifier)
                  .generateStory(_promptController.text),
              child:
                  Text('Generate Continuation', style: GoogleFonts.raleway()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputSection(String generatedStory) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Generated Story:',
              style: GoogleFonts.raleway(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            MarkdownBody(
              data: generatedStory,
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
