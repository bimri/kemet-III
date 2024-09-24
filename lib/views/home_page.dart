import 'package:flutter/material.dart';
import '../widgets/kemet_app_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kemet/utils/custom_page_route.dart';
import 'temporal_cultural_simulation.dart';
import 'oral_tradition_continuation.dart';
import 'cross_cultural_fusion_generator.dart';
import 'virtual_ancestral_dialogue.dart';
import 'predictive_language_evolution.dart';
import '../widgets/kemet_title.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const KemetAppBar(title: 'Kemet'),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: AnimationLimiter(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _featureList.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: 2,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildFeatureCard(
                        context,
                        _featureList[index]['title']!,
                        _featureList[index]['page']!,
                        _featureList[index]['icon']!,
                        _featureList[index]['color']!,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, Widget page,
      IconData icon, Color color) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          CustomPageRoute(builder: (context) => page),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color.withOpacity(0.4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 3,
                  child: Icon(icon, size: 48.0, color: Colors.white),
                ),
                const SizedBox(height: 8.0),
                Flexible(
                  flex: 2,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: KemetTitle(
                      text: title,
                      fontSize: 18.0,
                      color: Colors.white,
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
