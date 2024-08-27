import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/temporal_simulation_controller.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TemporalCulturalSimulation extends ConsumerStatefulWidget {
  const TemporalCulturalSimulation({super.key});

  @override
  ConsumerState<TemporalCulturalSimulation> createState() =>
      _TemporalCulturalSimulationState();
}

class _TemporalCulturalSimulationState
    extends ConsumerState<TemporalCulturalSimulation> {
  double _sliderValue = 2000.0;

  @override
  Widget build(BuildContext context) {
    final simulationText = ref.watch(temporalSimulationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Temporal Cultural Simulation')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/kemet-splashscreen.jpg',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Tooltip(
              message: 'Slide to select a year between 2000 and 2100 to simulate cultural changes',
              child: Slider(
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
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Tooltip(
                message: 'This text shows the simulated cultural changes for the selected year',
                child: MarkdownBody(
                  data: simulationText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
