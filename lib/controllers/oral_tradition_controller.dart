import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';

final oralTraditionProvider =
    StateNotifierProvider<OralTraditionController, String>((ref) {
  return OralTraditionController(GeminiService());
});

class OralTraditionController extends StateNotifier<String> {
  final GeminiService _geminiService;

  OralTraditionController(this._geminiService) : super('');

  Future<void> generateStory(String prompt) async {
    final fullPrompt = "Continue this African oral tradition: $prompt";
    final response =
        await _geminiService.generateContent(fullPrompt, 'gemini-pro');
    state = response;
  }
}
