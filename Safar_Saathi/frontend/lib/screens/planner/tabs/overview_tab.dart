import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

// This widget now ONLY contains the content for the tab, not the whole page structure.
class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold has been removed. The widget now returns a ListView directly.
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Each section now animates into view for a smooth, professional feel.
        FadeInDown(duration: const Duration(milliseconds: 400), child: _buildWelcomeHeader(context)),
        const SizedBox(height: 24),
        _buildKeyMetrics(context),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 200), child: _buildChartCard(context, title: 'Weekly Trip Volume', child: _buildBarChartPlaceholder())),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 300), child: _buildChartCard(context, title: 'Transport Mode Share', child: _buildPieChartPlaceholder())),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 400), child: _buildSystemStatusCard(context)),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 500), child: _buildRecentAlertsCard(context)),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 600), child: _buildQuickActionsCard(context)),
      ],
    );
  }

  // A more polished and visually engaging welcome header
  Widget _buildWelcomeHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back, Admin',
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Here's your real-time mobility snapshot for Kerala.",
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // Key metrics section with entrance animations
  Widget _buildKeyMetrics(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: FadeInLeft(delay: const Duration(milliseconds: 100), child: _buildMetricCard(icon: Icons.people_alt_outlined, label: 'Active Users', value: '12,847', change: '+1.2% this week', color: Colors.blue))),
            const SizedBox(width: 16),
            Expanded(child: FadeInRight(delay: const Duration(milliseconds: 100), child: _buildMetricCard(icon: Icons.map_outlined, label: 'Total Trips', value: '145,623', change: '+3.5% this week', color: Colors.green))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: FadeInLeft(delay: const Duration(milliseconds: 200), child: _buildMetricCard(icon: Icons.data_usage_outlined, label: 'Data Points', value: '2.3M', change: '+5.1% this week', color: Colors.purple))),
            const SizedBox(width: 16),
            Expanded(child: FadeInRight(delay: const Duration(milliseconds: 200), child: _buildMetricCard(icon: Icons.pie_chart_outline, label: 'Coverage', value: '78%', change: '-0.2% this week', color: Colors.orange))),
          ],
        ),
      ],
    );
  }

  // A reusable, redesigned metric card widget
  Widget _buildMetricCard({required IconData icon, required String label, required String value, required String change, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
            const SizedBox(height: 16),
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 8),
            Text(change, style: TextStyle(color: change.startsWith('+') ? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }

    // A generic card container for charts and other sections - THIS IS THE CORRECTED FUNCTION
  Widget _buildChartCard(BuildContext context, {required String title, required Widget child}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildBarChartPlaceholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      child: const Center(child: Text('[Bar Chart Placeholder]')),
    );
  }

  Widget _buildPieChartPlaceholder() {
    return Container(
      height: 200,
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
      child: const Center(child: Text('[Pie Chart Placeholder]')),
    );
  }

  Widget _buildSystemStatusCard(BuildContext context) {
    return _buildChartCard(
      context, // Passing context here
      title: 'System Status',
      child: Column(
        children: [
          _buildStatusItem(label: 'Data Collection', status: 'Operational', color: Colors.green),
          _buildStatusItem(label: 'Data Processing', status: 'Operational', color: Colors.green),
          _buildStatusItem(label: 'API Services', status: 'Maintenance', color: Colors.orange),
          _buildStatusItem(label: 'Data Validation', status: '79% Operational', color: Colors.green),
        ],
      ),
    );
  }

  Widget _buildStatusItem({required String label, required String status, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 12),
          const SizedBox(width: 8),
          Text(label),
          const Spacer(),
          Text(status, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecentAlertsCard(BuildContext context) {
    return _buildChartCard(
      context, // Passing context here
      title: 'Recent Alerts',
      child: Column(
        children: [
          _buildAlertItem(icon: Icons.warning_amber_rounded, color: Colors.orange, title: 'Unusual traffic pattern detected', time: '2 hours ago'),
          const Divider(),
          _buildAlertItem(icon: Icons.info_outline, color: Colors.blue, title: 'Data collection endpoint error rate > 5%', time: '5 hours ago'),
        ],
      ),
    );
  }

  Widget _buildAlertItem({required IconData icon, required Color color, required String title, required String time}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(time),
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildQuickActionsCard(BuildContext context) {
    return _buildChartCard(
      context, // Passing context here
      title: 'Quick Actions',
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
        children: [
          _buildActionChip(icon: Icons.explore_outlined, label: 'Explore Data'),
          _buildActionChip(icon: Icons.add_chart_outlined, label: 'Create Report'),
          _buildActionChip(icon: Icons.download_outlined, label: 'Export Data'),
          _buildActionChip(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildActionChip({required IconData icon, required String label}) {
    return ActionChip(
      avatar: Icon(icon),
      label: Text(label),
      onPressed: () {},
      padding: const EdgeInsets.all(12),
    );
  }
}

