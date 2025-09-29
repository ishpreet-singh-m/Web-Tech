import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the enhanced Profile Screen
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // State variables for the toggle switches remain the same
  bool _backgroundTracking = true;
  bool _dataSharing = true;
  bool _tripNotifications = true;
  bool _autoValidation = false;
  bool _batteryOptimization = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Profile & Settings',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Each section now animates into view
          FadeInUp(child: _buildProfileHeader()),
          const SizedBox(height: 24),
          FadeInUp(delay: const Duration(milliseconds: 100), child: _buildPrivacySection()),
          const SizedBox(height: 16),
          FadeInUp(delay: const Duration(milliseconds: 200), child: _buildNotificationsSection()),
          const SizedBox(height: 16),
          FadeInUp(delay: const Duration(milliseconds: 300), child: _buildPerformanceSection()),
          const SizedBox(height: 16),
          FadeInUp(delay: const Duration(milliseconds: 400), child: _buildDataExportSection()),
          const SizedBox(height: 16),
          FadeInUp(delay: const Duration(milliseconds: 500), child: _buildSupportSection()),
          const SizedBox(height: 16),
          FadeInUp(delay: const Duration(milliseconds: 600), child: _buildAboutSection()),
          const SizedBox(height: 24),
          FadeInUp(delay: const Duration(milliseconds: 700), child: _buildSignOutButton()),
        ],
      ),
    );
  }

  // A completely redesigned, more visually appealing profile header
  Widget _buildProfileHeader() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color.fromARGB(255, 239, 236, 236),
              child: Icon(Icons.person_rounded, size: 50, color: Colors.purple),
            ),
            const SizedBox(height: 12),
            const Text('Atlas User', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text('Member since October 1, 2024', style: TextStyle(color: Colors.white70)),
            const Divider(color: Colors.white54, height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProfileStat('156', 'Total Trips'),
                _buildProfileStat('3', 'Projects Helped'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  // Helper for creating the main section cards with a consistent style
  Widget _buildSectionCard({required String title, String? subtitle, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
  
  // Reusable widget for toggle items, now with leading icons
  Widget _buildToggleItem(String title, String subtitle, IconData icon, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeThumbColor: Theme.of(context).colorScheme.secondary,
    );
  }

  // Reusable widget for action items, now styled as a ListTile
  Widget _buildActionItem(String title, IconData icon, VoidCallback onPressed, {bool isDestructive = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: isDestructive ? Colors.redAccent : Colors.grey[600]),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.redAccent : Colors.black87)),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: onPressed,
    );
  }

  Widget _buildPrivacySection() {
    return _buildSectionCard(
      title: 'Privacy & Data',
      children: [
        _buildToggleItem('Background Tracking', 'Allow automatic trip detection', Icons.track_changes_rounded, _backgroundTracking, (value) {
          setState(() => _backgroundTracking = value);
        }),
        _buildToggleItem('Data Sharing', 'Share anonymized data for research', Icons.share_rounded, _dataSharing, (value) {
          setState(() => _dataSharing = value);
        }),
        const Divider(),
        _buildActionItem('View Privacy Policy', Icons.privacy_tip_rounded, () {}),
        _buildActionItem('Delete My Data', Icons.delete_forever_rounded, () {}, isDestructive: true),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSectionCard(
      title: 'Notifications',
      children: [
        _buildToggleItem('Trip Notifications', 'Get notified to validate trips', Icons.notifications_active_rounded, _tripNotifications, (value) {
          setState(() => _tripNotifications = value);
        }),
        _buildToggleItem('Auto Validation', 'Automatically validate high-confidence trips', Icons.check_circle_rounded, _autoValidation, (value) {
          setState(() => _autoValidation = value);
        }),
      ],
    );
  }

   Widget _buildPerformanceSection() {
    return _buildSectionCard(
      title: 'Performance',
      children: [
        _buildToggleItem('Battery Optimization', 'Reduce battery usage (may affect accuracy)', Icons.battery_charging_full_rounded, _batteryOptimization, (value) {
          setState(() => _batteryOptimization = value);
        }),
      ],
    );
  }

  Widget _buildDataExportSection() {
    return _buildSectionCard(
      title: 'Data Export',
      children: [
        _buildActionItem('Export Trip History', Icons.history_rounded, () {}),
        _buildActionItem('Export Points & Rewards', Icons.card_giftcard_rounded, () {}),
      ],
    );
  }
  
  Widget _buildSupportSection() {
    return _buildSectionCard(
      title: 'Support & Feedback',
      children: [
         _buildActionItem('Contact Support', Icons.support_agent_rounded, () {}),
         _buildActionItem('Send Feedback', Icons.feedback_rounded, () {}),
         _buildActionItem('Rate App', Icons.star_rate_rounded, () {}),
      ],
    );
  }

   Widget _buildAboutSection() {
    return _buildSectionCard(
      title: 'About Project Atlas',
      children: [
        const ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.info_rounded),
          title: Text('Version 1.0.0'),
          subtitle: Text('© 2024 NATPAC Kerala'),
        ),
         _buildActionItem('Terms of Service', Icons.description_rounded, () {}),
         _buildActionItem('Open Source Licenses', Icons.code_rounded, () {}),
      ],
    );
  }
  
  Widget _buildSignOutButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        foregroundColor: Colors.redAccent,
        elevation: 0,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Sign Out'),
    );
  }
}

