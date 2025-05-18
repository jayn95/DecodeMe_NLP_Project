import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String archetypeResult;
  final List<String> questions;
  final List<String> answers;
  final String recommendedJob; // ✅ New parameter
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.archetypeResult,
    required this.questions,
    required this.answers,
    required this.recommendedJob, // ✅ Add to constructor
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "You are: $archetypeResult",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Recommended Job: $recommendedJob", // ✅ Show the job
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Your answers:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  questions.length,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "${i + 1}. ${questions[i]}\n   ➔ ${answers[i]}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: onRestart,
                  child: const Text("Restart Quiz"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
