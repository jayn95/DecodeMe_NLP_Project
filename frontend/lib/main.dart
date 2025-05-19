import 'package:decodeme_nlp/game.dart';
import 'package:flutter/material.dart';
import 'package:decodeme_nlp/startpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DecodeMe Chatbot',
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/chat': (context) => const GameScreen(),
      },
    );
  }
}

// ...existing GameScreen, _GameScreenState, and _ChatMessage classes...
