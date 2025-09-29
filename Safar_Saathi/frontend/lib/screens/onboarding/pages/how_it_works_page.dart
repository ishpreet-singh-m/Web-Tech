import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned How It Works Page
class HowItWorksPage extends StatelessWidget {
  // Callback to trigger the next page in the parent controller
  

  const HowItWorksPage({super.key, });

  @override
  Widget build(BuildContext context) {
    // CORRECTED: The Scaffold has been removed. The widget now returns a Container directly.
    // This prevents conflicts with the parent OnboardingScreen's Scaffold.
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // Each section now animates into view for a smooth experience
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _buildHeader(context),
            ),
            const SizedBox(height: 32),
            // Each step card animates in with a delay for a staggered effect
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: _buildStep('1', 'Passive Monitoring', 'The app automatically detects when you travel using AI and sensors', context),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 300),
              child: _buildStep('2', 'Quick Validation', 'Occasionally validate detected trips with one tap to earn points', context),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: _buildStep('3', 'Make an Impact', 'Your anonymous data helps improve roads, buses, and city planning', context),
            ),
            const Spacer(),
            // The Continue button is now part of this page
          
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // A more polished and visually engaging header
  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.integration_instructions_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 60,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'How It Works',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // A redesigned step card for a cleaner, more modern look
  Widget _buildStep(String number, String title, String description, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Text(
                number,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(description, style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

