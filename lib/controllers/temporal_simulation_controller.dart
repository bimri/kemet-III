import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';

final temporalSimulationProvider =
    StateNotifierProvider<TemporalSimulationController, String>((ref) {
  return TemporalSimulationController(GeminiService());
});

class TemporalSimulationController extends StateNotifier<String> {
  final GeminiService _geminiService;

  TemporalSimulationController(this._geminiService) : super('');

  Future<void> generateSimulation(int year) async {
    final prompt =
        "Simulate the cultural evolution of a typical African village in the year $year";
    final response = await _geminiService.generateContent(prompt, 'gemini-pro');
    state = response;
  }
}
