import 'package:flutter/material.dart';
import 'screens/languagePage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(
    const MaterialApp(
      home: LanguagePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}