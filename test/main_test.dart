// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:kemet/models/message.dart';
// import 'package:kemet/models/generative_model_wrapper.dart';
// import 'package:kemet/services/gemini_service.dart';

// // Generate mocks
// @GenerateMocks([GenerativeModelWrapper])
// import 'main_test.mocks.dart';

// // Use a placeholder for the API key
// const String _kTestApiKey = 'TEST_API_KEY';

// void main() {
//   group('Message Model Tests', () {
//     test('should create a Message instance from JSON', () {
//       final json = {'role': 'user', 'content': 'Hello, World!'};
//       final message = Message.fromJson(json);

//       expect(message.role, 'user');
//       expect(message.content, 'Hello, World!');
//     });

//     test('should convert Message instance to JSON', () {
//       final message =
//           Message(role: 'assistant', content: 'How can I help you?');
//       final json = message.toJson();

//       expect(json['role'], 'assistant');
//       expect(json['content'], 'How can I help you?');
//     });
//   });

//   group('GeminiService Tests', () {
//     late MockGenerativeModelWrapper mockModel;
//     late GeminiService geminiService;

//     setUp(() {
//       mockModel = MockGenerativeModelWrapper();
//       geminiService = GeminiService(model: mockModel, apiKey: _kTestApiKey);
//     });

//     test('should generate content successfully', () async {
//       const prompt = 'Tell me a joke';
//       const expectedResponse = 'Why did the chicken cross the road?';

//       when(mockModel.generateContent(content: [Content.text(prompt)]))
//           .thenAnswer((_) async => GenerateContentResponse(
//                 candidates: [
//                   Candidate(
//                       content:
//                           Content(parts: [TextPart(text: expectedResponse)]))
//                 ],
//               ));

//       final result = await geminiService.generateContent(prompt, 'test-model');

//       expect(result, expectedResponse);
//       verify(mockModel.generateContent(content: [Content.text(prompt)]))
//           .called(1);
//     });

//     test('should throw exception when no text is generated', () async {
//       const prompt = 'Tell me a joke';

//       when(mockModel.generateContent(content: [Content.text(prompt)]))
//           .thenAnswer((_) async => GenerateContentResponse(candidates: []));

//       expect(() => geminiService.generateContent(prompt, 'test-model'),
//           throwsA(isA<Exception>()));
//     });

//     test('should throw exception when API call fails', () async {
//       const prompt = 'Tell me a joke';

//       when(mockModel.generateContent(content: [Content.text(prompt)]))
//           .thenThrow(Exception('API Error'));

//       expect(() => geminiService.generateContent(prompt, 'test-model'),
//           throwsA(isA<Exception>()));
//     });
//   });

//   group('GeminiService Integration Tests', () {
//     late GeminiService geminiService;

//     setUp(() {
//       // Use an environment variable or a secure method to get the API key
//       const apiKey = String.fromEnvironment('GEMINI_API_KEY');
//       geminiService = GeminiService(apiKey: apiKey);
//     });

//     test('should generate content with actual API', () async {
//       const prompt = 'What is the capital of France?';
//       final result = await geminiService.generateContent(
//           prompt, 'gemini-1.5-flash-latest');

//       expect(result, isNotEmpty);
//       expect(result.toLowerCase(), contains('paris'));
//     }, skip: 'Requires API key to run');

//     test('should handle long prompts', () async {
//       final longPrompt =
//           '${'Tell me about the history of ' * 50}artificial intelligence.';
//       final result = await geminiService.generateContent(
//           longPrompt, 'gemini-1.5-flash-latest');

//       expect(result, isNotEmpty);
//       expect(result.length, greaterThan(100));
//     }, skip: 'Requires API key to run');
//   });
// }
