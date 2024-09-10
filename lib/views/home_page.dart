import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'temporal_cultural_simulation.dart';
import 'oral_tradition_continuation.dart';
import 'cross_cultural_fusion_generator.dart';
import 'virtual_ancestral_dialogue.dart';
import 'predictive_language_evolution.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemBuilder: (context, index) {
            return _buildFeatureCard(
              context,
              _featureList[index]['title']!,
              _featureList[index]['page']!,
              _featureList[index]['icon']!,
              _featureList[index]['color']!,
            );
          },
          itemCount: _featureList.length,
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
      ),
    );
  }

  final List<Map<String, dynamic>> _featureList = [
    {
      'title': 'Temporal Simulation',
      'page': const TemporalCulturalSimulation(),
      'icon': Icons.timeline,
      'color': Colors.blue,
    },
    {
      'title': 'Oral Tradition',
      'page': const OralTraditionContinuation(),
      'icon': Icons.record_voice_over,
      'color': Colors.orange,
    },
    {
      'title': 'Cultural Fusion',
      'page': const CrossCulturalFusionGenerator(),
      'icon': Icons.diversity_3,
      'color': Colors.teal,
    },
    {
      'title': 'Ancestral Dialogue',
      'page': const VirtualAncestralDialogue(),
      'icon': Icons.family_restroom,
      'color': Colors.green,
    },
    {
      'title': 'Language Evolution',
      'page': const PredictiveLanguageEvolution(),
      'icon': Icons.language,
      'color': Colors.red,
    },
  ];
}
