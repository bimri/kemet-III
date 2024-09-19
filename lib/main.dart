import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';
import 'package:logger/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final logger = Logger();

  if (!Platform.isLinux) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      logger.i('Firebase initialized successfully');
    } catch (e, stackTrace) {
      logger.e('Failed to initialize Firebase', e, stackTrace);
      // Log more details about the error
      logger.e('Error details: $e');
      logger.e('Stack trace: $stackTrace');
    }
  } else {
    logger.w('Skipping Firebase initialization on Linux');
  }

  runApp(const ProviderScope(child: KemetApp()));
}

class Kemet extends StatelessWidget {
  const Kemet({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: KemetApp());
  }
}
