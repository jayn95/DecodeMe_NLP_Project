import 'package:flutter/material.dart';
import 'result_screen.dart'; // Add this import

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

  final List<Map<String, String>> _messages = [];
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

  @override
  void initState() {
    super.initState();
    _addBotMessage(_questions[_currentQuestion]);
  }

  Future<void> _addBotMessage(String message) async {
    setState(() {
      _messages.add({'type': 'bot', 'text': ''}); // placeholder
    });

    for (int i = 0; i <= message.length; i++) {
      await Future.delayed(const Duration(milliseconds: 25)); // typing speed
      setState(() {
        _messages[_messages.length - 1]['text'] = message.substring(0, i);
      });
    }
  }

  void _addUserMessage(String message) {
    _messages.add({'type': 'user', 'text': message});
  }

  void _submitAnswer() {
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
        final archetype = _calculateArchetype();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultScreen(
                  archetypeResult: archetype,
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
              constraints: BoxConstraints(
                maxWidth:
                    screenWidth * 0.7, // responsive width for smaller devices
              ),
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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20, // RETAIN your original font size
                ),
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
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Image.asset(
                  'assets/bgs/logo.png',
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                const SizedBox(height: 8),
                const SizedBox(height: 6),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 5.0,
                  ), // Added bottom padding
                  child: Text(
                    "Answer the questions as truthfully as you can.",
                    style: TextStyle(
                      color: Color.fromARGB(179, 0, 0, 0),
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
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1,
                    bottom: 70,
                  ),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (_) => _submitAnswer(),
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: const TextStyle(fontSize: 20),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 30,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _submitAnswer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
