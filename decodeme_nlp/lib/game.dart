import 'package:flutter/material.dart';
import 'result_screen.dart'; // Import the new result screen

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> _questions = [
    "Which activity do you enjoy most?",
    "What tool do you use the most?",
    "Describe your ideal project.",
  ];

  final List<String> _answers = [];
  int _currentQuestion = 0;
  final TextEditingController _controller = TextEditingController();

  final Map<String, String> _keywordToArchetype = {
    "design": "Hipster",
    "ui": "Hipster",
    "figma": "Hipster",
    "adobe": "Hipster",
    "terminal": "Hacker",
    "code": "Hacker",
    "algorithm": "Hacker",
    "hack": "Hacker",
    "system": "Hustler",
    "startup": "Hustler",
    "team": "Hustler",
    "slack": "Hustler",
    "research": "Guru",
    "paper": "Guru",
    "arxiv": "Guru",
    "scholar": "Guru",
  };

  void _submitAnswer() {
    final answer = _controller.text.trim();
    if (answer.isEmpty) return;
    setState(() {
      _answers.add(answer);
      _controller.clear();
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
      } else {
        // Calculate archetype and navigate to ResultScreen
        final archetypeResult = _calculateArchetype();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultScreen(
                  archetypeResult: archetypeResult,
                  questions: _questions,
                  answers: _answers,
                  onRestart: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GameScreen(),
                      ),
                    );
                  },
                ),
          ),
        );
      }
    });
  }

  String _calculateArchetype() {
    final Map<String, int> counts = {
      "Hipster": 0,
      "Hacker": 0,
      "Hustler": 0,
      "Guru": 0,
    };
    for (final answer in _answers) {
      final lower = answer.toLowerCase();
      _keywordToArchetype.forEach((keyword, archetype) {
        if (lower.contains(keyword)) {
          counts[archetype] = counts[archetype]! + 1;
        }
      });
    }
    String result = "a Mix!";
    int max = 0;
    counts.forEach((archetype, count) {
      if (count > max) {
        max = count;
        result = archetype;
      }
    });
    return result;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/bgs/background.png",
            ), // Ensure the image is added to your assets
            fit: BoxFit.fitWidth,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _questions[_currentQuestion],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:
                          Colors
                              .white, // Adjust for visibility on the background
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your answer here...',
                    ),
                    onSubmitted: (_) => _submitAnswer(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitAnswer,
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
