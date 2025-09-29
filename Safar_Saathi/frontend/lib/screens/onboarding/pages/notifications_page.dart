import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned Notifications Page
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // State for the toggles remains the same
  bool _reminders = true;
  bool _summary = true;
  bool _rewards = true;
  bool _updates = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
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
            'Choose Your Notifications',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 200),
          child: Text(
            'Customize when and how you want to hear from us',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 32),
        // Each notification toggle now animates in with a delay
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: _buildNotificationToggle('Trip Validation Reminders', 'Get notified when trips need validation', _reminders, (val) => setState(() => _reminders = val)),
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 400),
          child: _buildNotificationToggle('Weekly Summary', 'Your weekly travel insights and impact', _summary, (val) => setState(() => _summary = val)),
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 500),
          child: _buildNotificationToggle('Rewards & Achievements', 'New badges and reward opportunities', _rewards, (val) => setState(() => _rewards = val)),
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 600),
          child: _buildNotificationToggle('Transport Updates', "News about Kerala's transport improvements", _updates, (val) => setState(() => _updates = val)),
        ),
      ],
    );
  }

  // A more visually engaging header graphic
  Widget _buildHeaderGraphic(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Icon(
        Icons.notifications_active_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
    );
  }

  // A redesigned notification toggle with a cleaner Card-based design
  Widget _buildNotificationToggle(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
        activeThumbColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

