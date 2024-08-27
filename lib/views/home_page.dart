import 'package:flutter/material.dart';

import 'temporal_cultural_simulation.dart';
import 'oral_tradition_continuation.dart';
import 'cross_cultural_fusion_generator.dart';
import 'virtual_ancestral_dialogue.dart';
import 'predictive_language_evolution.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kemet',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 52, 20, 58),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        children: [
          _buildFeatureCard(
            context,
            'Temporal Simulation',
            const TemporalCulturalSimulation(),
            Icons.timeline,
            Colors.blue,
          ),
          _buildFeatureCard(
            context,
            'Oral Tradition',
            const OralTraditionContinuation(),
            Icons.record_voice_over,
            Colors.orange,
          ),
          _buildFeatureCard(
            context,
            'Cultural Fusion',
            const CrossCulturalFusionGenerator(),
            Icons.diversity_3,
            Colors.teal,
          ),
          _buildFeatureCard(
            context,
            'Ancestral Dialogue',
            const VirtualAncestralDialogue(),
            Icons.family_restroom,
            Colors.green,
          ),
          _buildFeatureCard(
            context,
            'Language Evolution',
            const PredictiveLanguageEvolution(),
            Icons.language,
            Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, Widget page,
      IconData icon, Color color) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48.0, color: Colors.white),
              const SizedBox(height: 16.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
