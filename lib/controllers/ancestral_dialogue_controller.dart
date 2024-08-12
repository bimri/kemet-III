import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/gemini_service.dart';
import '../models/message.dart';

final ancestralDialogueProvider =
    StateNotifierProvider<AncestralDialogueController, List<Message>>((ref) {
  return AncestralDialogueController(GeminiService());
});

class AncestralDialogueController extends StateNotifier<List<Message>> {
  final GeminiService _geminiService;

  AncestralDialogueController(this._geminiService) : super([]);

  Future<void> sendMessage(String userMessage) async {
    state = [...state, Message(role: 'user', content: userMessage)];

    final prompt =
        "As a wise African ancestor, respond to this message: $userMessage";
    final response = await _geminiService.generateContent(prompt, 'gemini-pro');

    state = [...state, Message(role: 'ancestor', content: response)];
  }
}
