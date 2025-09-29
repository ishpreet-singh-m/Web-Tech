import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned All Set Page
class AllSetPage extends StatelessWidget {

  const AllSetPage({super.key, });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        const SizedBox(height: 40),
        // Each section now animates into view for a smooth experience
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: _buildHeaderGraphic(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: Text(
            "You're Ready to Go!",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 200),
          child: Text(
            "Project Atlas is now monitoring your trips in the background. You'll get notifications to validate detected trips and earn points.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 32),
        // The info cards now animate in with a delay
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: _buildInfoCard(
            context,
            icon: Icons.card_giftcard_rounded,
            title: 'Welcome Bonus',
            subtitle: "You've earned 50 points for joining!",
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 400),
          child: _buildProTipsCard(context),
        ),
      ],
    );
  }

  // A more visually engaging header graphic
  Widget _buildHeaderGraphic(BuildContext context) {
    return ZoomIn(
      duration: const Duration(milliseconds: 600),
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ),
        child: Icon(
          Icons.check_circle_outline_rounded,
          color: Theme.of(context).colorScheme.secondary,
          size: 60,
        ),
      ),
    );
  }

  // A redesigned info card for a consistent and modern look
  Widget _buildInfoCard(BuildContext context, {required IconData icon, required String title, required String subtitle, required Color color}) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: color.withOpacity(0.8))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A specialized card for the "Pro Tips" section
  Widget _buildProTipsCard(BuildContext context) {
    final tips = [
      'Keep your phone with you during trips for accurate detection',
      'Validate trips quickly to earn bonus points',
      'Check weekly summaries to see your impact',
      'Use rewards for transport discounts',
    ];
    return Card(
      color: Colors.amber.withOpacity(0.1),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_rounded, color: Colors.amber.shade800),
                const SizedBox(width: 12),
                Text(
                  'Pro Tips',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber.shade800, fontSize: 16),
                ),
              ],
            ),
            const Divider(height: 24),
            ...tips.map((tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check, size: 16, color: Colors.amber.shade800),
                      const SizedBox(width: 8),
                      Expanded(child: Text(tip, style: TextStyle(color: Colors.amber.shade900))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

