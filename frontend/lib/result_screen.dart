import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final String archetypeResult;
  final List<String> questions;
  final List<String> answers;
  final String recommendedJob;
  final VoidCallback onRestart;
  final String jobDescription;

  const ResultScreen({
    super.key,
    required this.archetypeResult,
    required this.questions,
    required this.answers,
    required this.recommendedJob,
    required this.onRestart,
    required this.jobDescription,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Moving gradient by animating begin and end alignments smoothly
  LinearGradient _buildGradient() {
    final colors = const [
      Color(0xFFB3E5FC), // Light Blue 100
      Color(0xFF81D4FA), // Light Blue 200
      Color(0xFF4FC3F7), // Light Blue 300
      Color(0xFF29B6F6), // Light Blue 400
      Color(0xFF03A9F4), // Light Blue 500
    ];

    final animationValue = _controller.value;

    final beginAlignment = Alignment(
      -1.0 + 2.0 * animationValue,
      -1.0 + 2.0 * animationValue,
    );

    final endAlignment = Alignment(
      1.0 - 2.0 * animationValue,
      1.0 - 2.0 * animationValue,
    );

    return LinearGradient(
      begin: beginAlignment,
      end: endAlignment,
      colors: colors,
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(gradient: _buildGradient()),
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Add your logo here
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Image.asset(
                          'assets/bgs/logo.png', // Make sure this path matches your asset
                          height: 80,
                        ),
                      ),
                      // The result box
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Field: ${widget.archetypeResult}",
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Recommended Job: ${widget.recommendedJob}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                "Job Description:\n${widget.jobDescription}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                "Your answers:",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...List.generate(
                                widget.questions.length,
                                (i) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    "${i + 1}. ${widget.questions[i]}\n   ➔ ${widget.answers[i]}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: widget.onRestart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Restart Quiz"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
