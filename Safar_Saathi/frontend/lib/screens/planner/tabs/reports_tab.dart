import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// This widget now ONLY contains the content for the tab, not the whole page structure.
class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold and AppBar have been removed. The widget now returns a ListView directly.
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Each section now animates into view for a smooth, professional feel.
        FadeInUp(
          duration: const Duration(milliseconds: 400),
          child: _buildReportTemplatesCard(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 400),
          delay: const Duration(milliseconds: 100),
          child: _buildReportConfigurationCard(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 400),
          delay: const Duration(milliseconds: 200),
          child: _buildRecentReportsCard(context),
        ),
      ],
    );
  }

  // A reusable, redesigned section card for a consistent look and feel.
  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    Widget? action,
    required List<Widget> children,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                if (action != null) action,
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  // A more modern and visually engaging card for the report templates.
  Widget _buildReportTemplatesCard(BuildContext context) {
    return _buildSectionCard(
      context: context,
      title: 'Report Templates',
      children: [
        _buildTemplateItem(context, 'Monthly Mobility Report', 'Comprehensive monthly analysis of transport patterns', Icons.calendar_month_rounded),
        _buildTemplateItem(context, 'District Analysis', 'Detailed mobility insights for specific districts', Icons.travel_explore_rounded),
        _buildTemplateItem(context, 'Transport Mode Analysis', 'Deep dive into transport mode preferences', Icons.directions_bus_rounded),
        _buildTemplateItem(context, 'Peak Hour Analysis', 'Traffic patterns during rush hours', Icons.traffic_rounded),
      ],
    );
  }

  Widget _buildTemplateItem(BuildContext context, String title, String subtitle, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        child: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {},
    );
  }

  // A more polished placeholder for the report configuration section.
  Widget _buildReportConfigurationCard(BuildContext context) {
    return Card(
      child: Container(
        height: 150,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.description_outlined, size: 40, color: Colors.grey[400]),
            const SizedBox(height: 8),
            Text(
              'Select a report template to get started',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  // A redesigned recent reports section with improved visuals and actions.
  Widget _buildRecentReportsCard(BuildContext context) {
    return _buildSectionCard(
      context: context,
      title: 'Recent Reports',
      action: TextButton(onPressed: () {}, child: const Text('View All')),
      children: [
        _buildRecentReportItem(context, 'October 2024 Mobility Summary', 'Monthly Report • 2.4 MB'),
        _buildRecentReportItem(context, 'Ernakulam District Analysis', 'District Report • 1.8 MB'),
        _buildRecentReportItem(context, 'Public Transport Usage Trends', 'Mode Analysis • 1.1 MB'),
      ],
    );
  }

  Widget _buildRecentReportItem(BuildContext context, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        child: Icon(Icons.article_rounded, color: Theme.of(context).colorScheme.secondary),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.download_rounded), tooltip: 'Download'),
          IconButton(onPressed: (){}, icon: const Icon(Icons.share_rounded), tooltip: 'Share'),
        ],
      ),
    );
  }
}

