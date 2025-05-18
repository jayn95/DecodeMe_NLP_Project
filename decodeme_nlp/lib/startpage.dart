import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using Stack to place elements on top of the background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(32, 82, 137, 188)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Scrollable content
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(),
              // Logo image
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Image.asset(
                  'assets/bgs/logo_landing.png',
                  width: 600,
                  height: 600,
                  fit: BoxFit.contain,
                ),
              ),

              // Get Started button
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFADD8E6),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 32,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),

              const SizedBox(height: 80),

              // Second section - Features
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'We believe in helping people',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Find your confidence as you explore\nyour path in ICT.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 40),

                    // Feature cards with consistent sizing
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth > 700) {
                            double cardWidth = (constraints.maxWidth - 32) / 3;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildFeatureCard(
                                  'Explore',
                                  'Answer quick questions to reveal careers that match your interests.',
                                  Icons.search,
                                  width: cardWidth,
                                ),
                                const SizedBox(width: 16),
                                _buildFeatureCard(
                                  'Match',
                                  'Explore tailored career options based on your answers.',
                                  Icons.person,
                                  width: cardWidth,
                                ),
                                const SizedBox(width: 16),
                                _buildFeatureCard(
                                  'Start',
                                  'Take the first step toward your future in ICT.',
                                  Icons.location_on,
                                  width: cardWidth,
                                ),
                              ],
                            );
                          } else {
                            double cardWidth =
                                constraints.maxWidth > 400
                                    ? 400
                                    : constraints.maxWidth - 32;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _buildFeatureCard(
                                  'Explore',
                                  'Answer quick questions to reveal careers that match your interests.',
                                  Icons.search,
                                  width: cardWidth,
                                ),
                                const SizedBox(height: 16),
                                _buildFeatureCard(
                                  'Match',
                                  'Explore tailored career options based on your answers.',
                                  Icons.person,
                                  width: cardWidth,
                                ),
                                const SizedBox(height: 16),
                                _buildFeatureCard(
                                  'Start',
                                  'Take the first step toward your future in ICT.',
                                  Icons.location_on,
                                  width: cardWidth,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

              // Third section - Meet the Team
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'Meet the Team',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Passionate and driven — we\'re a group of people dedicated to helping you navigate your future in ICT.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Team member grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final availableWidth = constraints.maxWidth;

                        if (availableWidth > 700) {
                          return Column(
                            children: [
                              // First row - 3 members
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Nel Adryan Alanan',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Pauline Joy Bautista',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Ashley Denise Feliciano',
                                      'Ash.JPG',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Second row - 2 members
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(width: availableWidth * 0.16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Patrick Joseph Napud',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Jill Navarra',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  SizedBox(width: availableWidth * 0.16),
                                ],
                              ),
                            ],
                          );
                        } else if (availableWidth > 500) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Nel Adryan Alanan',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Pauline Joy Bautista',
                                      'Ash.JPG',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Ashley Denise Feliciano',
                                      'Ash.JPG',
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildTeamMemberCard(
                                      'Patrick Joseph Napud',
                                      'Ash.JPG',
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: availableWidth / 2,
                                child: _buildTeamMemberCard(
                                  'Jill Navarra',
                                  'Ash.JPG',
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              _buildTeamMemberCard(
                                'Nel Adryan Alanan',
                                'Ash.JPG',
                              ),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard(
                                'Pauline Joy Bautista',
                                'Ash.JPG',
                              ),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard(
                                'Ashley Denise Feliciano',
                                'Ash.JPG',
                              ),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard(
                                'Patrick Joseph Napud',
                                'Ash.JPG',
                              ),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard('Jill Navarra', 'Ash.JPG'),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  // Feature card with adaptive width and flexible height
  Widget _buildFeatureCard(
    String title,
    String description,
    IconData icon, {
    double? width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamMemberCard(String name, String imageFileName) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate image size with padding (80% of available width)
        final double imageSize = constraints.maxWidth * 0.8;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: Image.asset('assets/$imageFileName', fit: BoxFit.cover),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
