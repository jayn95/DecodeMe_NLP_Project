import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'result_screen.dart';
import 'startpage.dart'; // Make sure you have this screen implemented
// import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _questions = [
    "Which activity do you enjoy most?",
    "What tool do you use the most?",
    "Describe your ideal project.",
  ];

  final List<Map<String, String>> _messages = [];
  final List<String> _answers = [];
  int _currentQuestion = 0;
  final TextEditingController _controller = TextEditingController();

  late AnimationController _logoAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  bool _showChat = false;

  @override
  void initState() {
    super.initState();

    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoAnimationController, curve: Curves.easeOut),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeIn),
      ),
    );

    _logoAnimationController.forward();

    _logoAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showChat = true;
        });
        _addBotMessage(_questions[_currentQuestion]);
      }
    });
  }

  Future<void> _addBotMessage(String message) async {
    setState(() {
      _messages.add({'type': 'bot', 'text': ''}); // placeholder
    });

    for (int i = 0; i <= message.length; i++) {
      await Future.delayed(const Duration(milliseconds: 25));
      setState(() {
        _messages[_messages.length - 1]['text'] = message.substring(0, i);
      });
    }
  }

  void _addUserMessage(String message) {
    _messages.add({'type': 'user', 'text': message});
  }

  Future<void> _submitAnswer() async {
    final answer = _controller.text.trim();
    if (answer.isEmpty) return;

    setState(() {
      _addUserMessage(answer);
      _answers.add(answer);
      _controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 300), () async {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
        await _addBotMessage(_questions[_currentQuestion]);
      } else {
        // Call backend model here instead of local logic
        final predictionData = await _fetchModelPrediction(_answers);
        if (predictionData == null) {
          // Show error message in chat or fallback
          await _addBotMessage(
            "Sorry, failed to get recommendation from server.",
          );
        } else {
          // Extract final recommendation from server response
          final archetype = predictionData['final_subfield'] ?? "Unknown";
          final recommendedJob = predictionData['recommended_job'] ?? "N/A";

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ResultScreen(
                    archetypeResult: archetype,
                    questions: _questions,
                    answers: _answers,
                    recommendedJob: recommendedJob,
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
      }
    });
  }

  Future<Map<String, dynamic>?> _fetchModelPrediction(
    List<String> answers,
  ) async {
    try {
      const bool isProduction = bool.fromEnvironment('dart.vm.product');

      const String baseUrl =
          isProduction
              ? 'https://decodeme-nlp-project.onrender.com'
              : 'http://127.0.0.1:5000'; // your model server URL

      final url = Uri.parse('$baseUrl/predict'); // your model server URL
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'answers': answers}),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error from backend: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception during HTTP request: $e');
      return null;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _logoAnimationController.dispose();
    super.dispose();
  }

  Widget _buildMessage(Map<String, String> message) {
    final isBot = message['type'] == 'bot';
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
            isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isBot)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset("assets/bgs/bot.png", width: 40, height: 40),
            ),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xA88ECAE6),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                message['text']!,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                softWrap: true,
              ),
            ),
          ),
          if (!isBot)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset("assets/bgs/user.png", width: 40, height: 40),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgs/chatbg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 18),

                  Center(
                    child: AnimatedBuilder(
                      animation: _logoAnimationController,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _logoOpacityAnimation.value,
                          child: Transform.scale(
                            scale: _logoScaleAnimation.value,
                            child: child,
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/bgs/logo.png',
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Expanded(
                    child:
                        _showChat
                            ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                      vertical: 5.0,
                                    ),
                                    child: Text(
                                      "Answer the questions as truthfully as you can.",
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                          179,
                                          0,
                                          0,
                                          0,
                                        ),
                                        fontSize: 24,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: _messages.length,
                                      itemBuilder: (context, index) {
                                        return _buildMessage(_messages[index]);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 70),
                                    child: TextField(
                                      controller: _controller,
                                      onSubmitted: (_) => _submitAnswer(),
                                      textAlign: TextAlign.justify,
                                      maxLines: 1,
                                      maxLength: 200, // <-- Add this line
                                      decoration: InputDecoration(
                                        hintText: 'Type your message...',
                                        hintStyle: const TextStyle(
                                          fontSize: 20,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              vertical: 30,
                                              horizontal: 30,
                                            ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.arrow_forward),
                                          onPressed: _submitAnswer,
                                        ),
                                        counterText:
                                            '', // Optional: Hide the character counter below the field
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : const SizedBox.expand(),
                  ),
                ],
              ),

              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
