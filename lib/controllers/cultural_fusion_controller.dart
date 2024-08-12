import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';

final culturalFusionProvider =
    StateNotifierProvider<CulturalFusionController, String>((ref) {
  return CulturalFusionController(GeminiService());
});

class CulturalFusionController extends StateNotifier<String> {
  final GeminiService _geminiService;

  CulturalFusionController(this._geminiService) : super('');

  Future<void> generateFusion(double fusionLevel) async {
    final prompt =
        "Generate a description of a cultural fusion between traditional African art and futuristic design, with a fusion level of ${fusionLevel * 100}%";
    final response = await _geminiService.generateContent(prompt, 'gemini-pro');
    state = response;
  }
}
