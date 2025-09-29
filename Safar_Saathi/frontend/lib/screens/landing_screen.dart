import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
// Using relative imports is often more reliable for files within the same feature folder.
import 'onboarding/onboarding_screen.dart';
import 'planner/planner_login_screen.dart';

// Main widget for the redesigned Landing Screen
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            // Each section animates into view for a smooth entry
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _buildHeader(context),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: _buildOptionCard(
                context,
                icon: Icons.phone_android_rounded,
                title: 'Citizen Mobile App',
                description: 'Contribute to your city\'s transport improvement by sharing your travel data.',
                features: ['Privacy-first design', 'Passive trip detection', 'Gamification & rewards'],
                buttonText: 'Open Citizen App',
                isPrimary: true, // This will be the main, filled button
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    // This correctly navigates to the OnboardingScreen, which starts with the WelcomePage.
                    MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: _buildOptionCard(
                context,
                icon: Icons.dashboard_rounded,
                title: 'NATPAC Planner Dashboard',
                description: 'Analyze aggregated mobility data to make informed transport planning decisions.',
                features: ['Interactive data visualization', 'Real-time analytics', 'Export & reporting tools'],
                buttonText: 'Open Planner Dashboard',
                isPrimary: false, // This will be the secondary, outlined button
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PlannerLoginScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
             FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 600),
               child: const Text(
                '© 2024 NATPAC Kerala - A Government of Kerala Initiative',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
                           ),
             ),
          ],
        ),
      ),
    );
  }

  // A more visually engaging header
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(Icons.map_rounded, color: Theme.of(context).colorScheme.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(
          'Project Atlas',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Kerala’s smart mobility data collection platform.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
        ),
         const SizedBox(height: 8),
        Text(
          'NATPAC Kerala Initiative',
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }

  // A redesigned, more attractive option card
  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
    required String buttonText,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              child: Icon(icon, color: Theme.of(context).colorScheme.secondary, size: 28),
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
            const Divider(height: 32),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, color: Theme.of(context).colorScheme.secondary, size: 20),
                      const SizedBox(width: 12),
                      Text(feature),
                    ],
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: isPrimary
                  ? ElevatedButton(
                      onPressed: onPressed,
                      child: Text(buttonText),
                    )
                  : OutlinedButton(
                      onPressed: onPressed,
                      child: Text(buttonText),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

