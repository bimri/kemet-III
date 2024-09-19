import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kemet/models/generative_model_wrapper.dart';

class GeminiService {
  final GenerativeModelWrapper model;

  GeminiService({GenerativeModelWrapper? model, required String apiKey})
      : model = model ?? GenerativeModelImpl(GenerativeModel(
          model: 'gemini-1.5-pro',
          apiKey: apiKey,
        ));

  Future<String> generateContent(String prompt, String modelName) async {
    try {
      final response = await model.generateContent(content: [Content.text(prompt)]);
      if (response.candidates.isEmpty || response.candidates.first.content.parts.isEmpty) {
        throw Exception('No content generated');
      }
      return response.candidates.first.content.parts.first.toString();
    } catch (e) {
      throw Exception('Failed to generate content: $e');
    }
  }
}
