import 'package:flutter/material.dart';
import '../widgets/kemet_app_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../controllers/temporal_simulation_controller.dart';

class TemporalCulturalSimulation extends ConsumerStatefulWidget {
  const TemporalCulturalSimulation({super.key});

  @override
  ConsumerState<TemporalCulturalSimulation> createState() =>
      _TemporalCulturalSimulationState();
}

class _TemporalCulturalSimulationState
    extends ConsumerState<TemporalCulturalSimulation>
    with SingleTickerProviderStateMixin {
  double _sliderValue = 2000.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
    final simulationText = ref.watch(temporalSimulationProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const KemetAppBar(title: 'Temporal Cultural Simulation'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/temporal.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
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
                      child: Column(
                        children: [
                          Text(
                            'Year: ${_sliderValue.round()}',
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Slider(
                            min: 2000.0,
                            max: 2100.0,
                            divisions: 10,
                            label: _sliderValue.round().toString(),
                            value: _sliderValue,
                            onChanged: (double newValue) {
                              setState(() {
                                _sliderValue = newValue;
                                ref
                                    .read(temporalSimulationProvider.notifier)
                                    .generateSimulation(newValue.round());
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: MarkdownBody(
                                data: simulationText,
                                styleSheet: MarkdownStyleSheet(
                                  p: GoogleFonts.lato(
                                    textStyle: const TextStyle(fontSize: 16),
                                  ),
                                  h1: GoogleFonts.raleway(
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
