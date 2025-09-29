import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned Welcome Page
class WelcomePage extends StatelessWidget {
  // Callback to trigger the next page in the parent controller
  

  const WelcomePage({super.key, });

  @override
  Widget build(BuildContext context) {
    // MODIFIED: Wrapped the content in a Container to explicitly set a white background.
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            // Each element now animates into view for a more engaging experience
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _buildHeaderGraphic(context),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 200),
              child: Text(
                "Help Improve Kerala's Transport",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 400),
              child: Text(
                'Join thousands of Kerala residents contributing to better transport planning by sharing anonymous travel data.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 600),
              child: _buildPrivacyCard(context),
            ),
            const Spacer(),
            // The continue button is now part of this page
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // A more visually engaging graphic instead of a simple icon
  Widget _buildHeaderGraphic(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Icon(
        Icons.map_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
    );
  }

  // A redesigned privacy card that uses the app's theme colors
  Widget _buildPrivacyCard(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shield_outlined, color: Theme.of(context).colorScheme.secondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Your privacy is our priority. All data is anonymized and encrypted.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

