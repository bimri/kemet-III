import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  runApp(const Kemet());
}

class Kemet extends StatelessWidget {
  const Kemet({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: CultureBridgeApp());
  }
}
