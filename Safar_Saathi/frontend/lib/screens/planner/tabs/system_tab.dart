import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// This widget now ONLY contains the content for the tab, not the whole page structure.
class SystemTab extends StatefulWidget {
  const SystemTab({super.key});

  @override
  State<SystemTab> createState() => _SystemTabState();
}

class _SystemTabState extends State<SystemTab> {
  int _selectedSettingsTab = 0;

  @override
  Widget build(BuildContext context) {
    // The Scaffold has been removed. The widget now returns a ListView directly.
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Each section now animates into view for a smooth, professional feel.
        FadeInDown(duration: const Duration(milliseconds: 400), child: _buildHeader(context)),
        const SizedBox(height: 24),
        // The stat cards are now in a Column to prevent overflow on mobile.
        FadeInUp(delay: const Duration(milliseconds: 100), child: _buildSystemHealthCard()),
        const SizedBox(height: 16),
        FadeInUp(delay: const Duration(milliseconds: 200), child: _buildDataPipelineCard()),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 300), child: _buildSettingsTabs(context)),
        const SizedBox(height: 16),
        FadeInUp(delay: const Duration(milliseconds: 400), child: _buildSettingsContentCard(context)),
      ],
    );
  }

  // A more polished and visually engaging header
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Management',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Monitor and configure Project Atlas infrastructure',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.download_for_offline_outlined), onPressed: () {}, label: const Text('Download Logs'))),
            const SizedBox(width: 16),
            Expanded(child: ElevatedButton.icon(icon: const Icon(Icons.backup_outlined), onPressed: () {}, label: const Text('System Backup'))),
          ],
        ),
      ],
    );
  }

  // Redesigned System Health card for clarity
  Widget _buildSystemHealthCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCardHeader('System Health', 'Healthy', Colors.green),
            const SizedBox(height: 12),
            _buildGaugeRow('Uptime', 98.6, Colors.green),
            _buildGaugeRow('Processing Speed', 1247, Colors.blue, unit: ' tps'),
            _buildGaugeRow('Storage Used', 78, Colors.orange),
          ],
        ),
      ),
    );
  }
  
  // Redesigned Data Pipeline card
  Widget _buildDataPipelineCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             _buildCardHeader('Data Pipeline', 'Processing', Colors.orange),
            const Divider(height: 24),
            _buildDetailRow('Queue Size', '1,234 items'),
             _buildDetailRow('Processing Rate', '66.7%'),
              _buildDetailRow('Error Rate', '0.1%'),
          ],
        ),
      ),
    );
  }

  Widget _buildCardHeader(String title, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildGaugeRow(String label, double value, Color color, {String unit = '%'}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label),
              Text('$value$unit', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: (unit == '%') ? value / 100 : null,
              backgroundColor: color.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  
  // A more interactive and visually appealing tab bar for settings
  Widget _buildSettingsTabs(BuildContext context) {
    final tabs = ['System Settings', 'User Management', 'System Logs'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(tabs.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(tabs[index]),
              selected: _selectedSettingsTab == index,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedSettingsTab = index;
                  });
                }
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(color: _selectedSettingsTab == index ? Colors.white : Colors.black87),
            ),
          );
        }),
      ),
    );
  }

  // A cleaner, more organized card for displaying settings content
  Widget _buildSettingsContentCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Data Collection Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildSettingSwitch('Data Collection', 'Enable/disable trip data collection', true),
            _buildSettingSwitch('Real-time Processing', 'Process data as it arrives', true),
            _buildSettingSwitch('Auto-validation', 'Automatically validate high-confidence trips', false),
            const Divider(height: 32),
            const Text('Privacy & Security', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildSettingSwitch('Data Anonymization', 'Anonymize all personal user data', true),
            _buildSettingSwitch('Backup Enabled', 'Perform automatic daily backups', true),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingSwitch(String title, String subtitle, bool value) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      value: value,
      onChanged: (bool newValue) {
        // Placeholder for state management
      },
      contentPadding: EdgeInsets.zero,
      activeThumbColor: Theme.of(context).colorScheme.secondary,
    );
  }
}

