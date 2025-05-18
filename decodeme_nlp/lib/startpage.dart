import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Color(0xFFE0F7FA)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Image.asset('assets/logo.png', height: 80), // use your logo
                  const SizedBox(height: 16),
                  const Text(
                    'Unlock Your Career Path in ICT',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed:
                        () => Navigator.pushReplacementNamed(context, '/chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Get Started'),
                  ),
                ],
              ),
            ),

            // Features Section
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'We believe in helping people',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find your confidence as you explore your path in ICT.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FeatureCard(
                        title: 'Explore',
                        icon: Icons.search,
                        text: 'Answer quick questions to reveal careers.',
                      ),
                      FeatureCard(
                        title: 'Match',
                        icon: Icons.person,
                        text: 'Explore tailored career options.',
                      ),
                      FeatureCard(
                        title: 'Start',
                        icon: Icons.location_on,
                        text: 'Take the first step toward ICT.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Team Section
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Meet the Team',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Passionate and driven – we’re here to help you navigate your future.',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      TeamPlaceholder(),
                      TeamPlaceholder(),
                      TeamPlaceholder(),
                      TeamPlaceholder(),
                      TeamPlaceholder(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Icon(icon, size: 32),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class TeamPlaceholder extends StatelessWidget {
  const TeamPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
