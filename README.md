# Kemet

Kemet is an innovative Flutter application that leverages AI to explore and preserve African cultural heritage while imagining its future evolution. Named after the ancient Egyptian word for Egypt, Kemet serves as a digital time machine and cultural fusion laboratory, utilizing the Gemini API to bridge past, present, and future African cultures.

## Features

1. **Temporal Cultural Simulation**: Visualize the evolution of African societies from 2000 to 2100 using an interactive 3D globe.

2. **AI-Powered Oral Tradition Continuation**: Preserve and reimagine oral traditions by continuing traditional stories using AI.

3. **Cross-Cultural Fusion Generator**: Blend traditional African art with futuristic design using an adjustable fusion level.

4. **Virtual Ancestral Dialogue**: Engage in conversations with an AI-powered "wise African ancestor."

5. **Predictive Language Evolution**: Predict how words or phrases from African languages might evolve over time.

## Tech Stack

- Flutter for cross-platform mobile development
- Firebase for backend services
- Hive for local data storage
- Gemini API for AI-powered content generation
- Custom animations and visualizations

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK
- Firebase account
- Gemini API key

### Installation

1. Clone the repository:
   ```
   git clone https://github.com/yourusername/kemet.git
   ```

2. Navigate to the project directory:
   ```
   cd kemet
   ```

3. Install dependencies:
   ```
   flutter pub get
   ```

4. Set up Firebase:
   - Create a new Firebase project
   - Add your Flutter app to the Firebase project
   - Download the `google-services.json` file and place it in the `android/app` directory
   - Download the `GoogleService-Info.plist` file and place it in the `ios/Runner` directory

5. Set up Gemini API:
   - Obtain an API key from the Google AI Studio
   - Replace `'YOUR_API_KEY'` in the `GeminiService` class with your actual API key

### Running the App

Run the app using the following command:
```
flutter run
```

## Contributing

We welcome contributions to Kemet! Please feel free to submit pull requests or open issues to suggest improvements or report bugs.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

- Thanks to the Gemini API team for providing the AI capabilities
- Inspiration drawn from the rich cultural heritage of Africa, particularly ancient Egyptian civilization
