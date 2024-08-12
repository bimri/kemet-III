import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';

final languageEvolutionProvider = StateNotifierProvider<LanguageEvolutionController, String>((ref) {
  return LanguageEvolutionController(GeminiService());
});

class LanguageEvolutionController extends StateNotifier<String> {
  final GeminiService _geminiService;

  LanguageEvolutionController(this._geminiService) : super('');

  Future<void> evolveLanguage(String word, int yearsFuture) async {
    final prompt = "Evolve this word or phrase from an African language $yearsFuture years into the future, considering technological and cultural changes: $word";
    final response = await _geminiService.generateContent(prompt, 'gemini-pro');
    state = response;
  }
}