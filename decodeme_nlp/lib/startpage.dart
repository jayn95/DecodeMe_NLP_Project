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
            colors: [
              Colors.white,
              Color.fromARGB(32, 82, 137, 188),
            ],
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
              const SizedBox(height: 120),
              // App logo or title
              const Text(
                'DecodeMe',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              // Subtitle or welcome message
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Unlock Your Career Path in ICT',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Get Started button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the chat route
                    Navigator.pushNamed(context, '/chat');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFADD8E6),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 80),

              // Second section - Features
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Feature cards with consistent sizing
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LayoutBuilder(builder: (context, constraints) {
                        // For larger screens, show in a row
                        if (constraints.maxWidth > 700) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: (constraints.maxWidth - 32) / 3,
                                child: _buildFeatureCard(
                                  'Explore',
                                  'Answer quick questions to reveal careers that match your interests.',
                                  Icons.search,
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: (constraints.maxWidth - 32) / 3,
                                child: _buildFeatureCard(
                                  'Match',
                                  'Explore tailored career options based on your answers.',
                                  Icons.person,
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: (constraints.maxWidth - 32) / 3,
                                child: _buildFeatureCard(
                                  'Start',
                                  'Take the first step toward your future in ICT.',
                                  Icons.location_on,
                                ),
                              ),
                            ],
                          );
                        }
                        // For smaller screens, stack vertically but with fixed width
                        else {
                          // Fixed width for smaller screens - adjust this value as needed
                          double cardWidth = constraints.maxWidth > 400
                              ? 400
                              : constraints.maxWidth - 32;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: cardWidth,
                                child: _buildFeatureCard(
                                  'Explore',
                                  'Answer quick questions to reveal careers that match your interests.',
                                  Icons.search,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: cardWidth,
                                child: _buildFeatureCard(
                                  'Match',
                                  'Explore tailored career options based on your answers.',
                                  Icons.person,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: cardWidth,
                                child: _buildFeatureCard(
                                  'Start',
                                  'Take the first step toward your future in ICT.',
                                  Icons.location_on,
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),

              // Third section - Meet the Team
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Team member grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Get the available width
                        final availableWidth = constraints.maxWidth;

                        // Decide layout based on screen width
                        if (availableWidth > 700) {
                          return Column(
                            children: [
                              // First row - 3 members
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Nel Adryan Alanan')),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Pauline Joy Bautista')),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Ashley Denise Feliciano')),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Second row - 2 members
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: availableWidth *
                                          0.16), // For centering the 2 cards
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Patrick Joseph Napud')),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child:
                                          _buildTeamMemberCard('Jill Navarra')),
                                  SizedBox(
                                      width: availableWidth *
                                          0.16), // For centering the 2 cards
                                ],
                              ),
                            ],
                          );
                        } else if (availableWidth > 500) {
                          // Medium screens - 2 columns grid
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Nel Adryan Alanan')),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Pauline Joy Bautista')),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Ashley Denise Feliciano')),
                                  const SizedBox(width: 16),
                                  Expanded(
                                      child: _buildTeamMemberCard(
                                          'Patrick Joseph Napud')),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: availableWidth / 2,
                                child: _buildTeamMemberCard('Jill Navarra'),
                              ),
                            ],
                          );
                        } else {
                          // Small screens - single column
                          return Column(
                            children: [
                              _buildTeamMemberCard('Nel Adryan Alanan'),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard('Pauline Joy Bautista'),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard('Ashley Denise Feliciano'),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard('Patrick Joseph Napud'),
                              const SizedBox(height: 16),
                              _buildTeamMemberCard('Jill Navarra'),
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

  // Helper method to build feature cards - ensuring consistent heights
  Widget _buildFeatureCard(String title, String description, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 220,
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
          Icon(
            icon,
            size: 48,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build team member cards with photos
  Widget _buildTeamMemberCard(String name) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: name == 'Nel Adryan Alanan' ? Colors.blue : Colors.transparent,
          width: 2,
        ),
      ),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Photo
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey[300]!,
                width: 2,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/Ash.JPG'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
      ),
    );
  }
}
