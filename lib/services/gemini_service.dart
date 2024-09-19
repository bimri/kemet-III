import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  late final GenerativeModel _model;

  GeminiService({String modelName = 'gemini-1.5-flash-latest'}) {
    // Initialize the model in the constructor
    _model = GenerativeModel(
      model: modelName,
      apiKey:
          'GOOGLE_API_KEY', // Replace with your actual API key
    );
  }

  Future<String> generateContent(String prompt, String model) async {
    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text == null) {
        throw Exception('No text generated');
      }

      return response.text!;
    } catch (e) {
      throw Exception('Failed to generate content: $e');
    }
  }
}