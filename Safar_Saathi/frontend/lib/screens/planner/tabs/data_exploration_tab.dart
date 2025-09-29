import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// This widget now ONLY contains the content for the tab, not the whole page structure.
class DataExplorationTab extends StatelessWidget {
  const DataExplorationTab({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold has been removed. The widget now returns a ListView directly.
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Each section now animates into view for a smooth, professional feel.
        FadeInDown(duration: const Duration(milliseconds: 400), child: _buildHeader(context)),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 100), child: _buildFiltersCard(context)),
        const SizedBox(height: 24),
        // This now uses the more robust Column/Row layout
        _buildSummaryStats(),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 400), child: _buildVisualizationCard(context)),
        const SizedBox(height: 24),
        FadeInUp(delay: const Duration(milliseconds: 500), child: _buildPopularRoutesCard(context)),
      ],
    );
  }

  // A more polished and visually engaging header
  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Data Exploration',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Interactive analysis of mobility patterns across Kerala',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: OutlinedButton.icon(icon: const Icon(Icons.download_outlined), onPressed: () {}, label: const Text('Export View'))),
            const SizedBox(width: 16),
            Expanded(child: ElevatedButton.icon(icon: const Icon(Icons.add_chart_outlined), onPressed: () {}, label: const Text('Create Report'))),
          ],
        )
      ],
    );
  }

  // A redesigned, more user-friendly filters section
  Widget _buildFiltersCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDropdownField('Date Range', Icons.date_range_outlined, ['Last 7 days', 'Last 30 days', 'This Year']),
            const SizedBox(height: 12),
            _buildDropdownField('Transport Mode', Icons.directions_bus_outlined, ['All Modes', 'Bus', 'Car', 'Walk']),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {}, child: const Text('Reset')),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: () {}, child: const Text('Apply Filters')),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, IconData icon, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon),
      ),
      initialValue: items.first,
      items: items.map((String value) => DropdownMenuItem<String>(value: value, child: Text(value))).toList(),
      onChanged: (_) {},
    );
  }

  // MODIFIED: This now uses a Column of Rows instead of a GridView for a more stable layout.
  Widget _buildSummaryStats() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: FadeInLeft(delay: const Duration(milliseconds: 200), child: _buildStatCard('Filtered Trips', '45,231', Icons.filter_alt_rounded, Colors.blue))),
            const SizedBox(width: 16),
            Expanded(child: FadeInRight(delay: const Duration(milliseconds: 200), child: _buildStatCard('Avg. Distance', '8.7 km', Icons.space_dashboard_rounded, Colors.green))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
           children: [
            Expanded(child: FadeInLeft(delay: const Duration(milliseconds: 300), child: _buildStatCard('Peak Hour', '9:00 AM', Icons.access_time_filled_rounded, Colors.purple))),
            const SizedBox(width: 16),
            Expanded(child: FadeInRight(delay: const Duration(milliseconds: 300), child: _buildStatCard('Top Route', 'Kochi → EKM', Icons.trending_up_rounded, Colors.orange))),
           ],
        )
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color)),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // A more polished visualization section
  Widget _buildVisualizationCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias, // Ensures the map respects the card's rounded corners
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Visualization', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildVisChip('Heatmap', true, context),
                      _buildVisChip('Flow Lines', false, context),
                      _buildVisChip('Density', false, context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey[800]!, Colors.grey[900]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text('Kerala Mobility Heatmap\n[Map Placeholder]', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisChip(String label, bool isSelected, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {},
        selectedColor: Theme.of(context).colorScheme.primary,
        labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
      ),
    );
  }

  // A cleaner, more readable list of popular routes
  Widget _buildPopularRoutesCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Popular Routes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(height: 24),
            _buildRouteRow('1', 'Kochi → Ernakulam', '12 km • Bus', '3,245 trips', context),
            _buildRouteRow('2', 'Trivandrum → Technopark', '8 km • Car', '2,891 trips', context),
            _buildRouteRow('3', 'Thrissur → Guruvayur', '25 km • Bus', '1,876 trips', context),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteRow(String rank, String route, String details, String trips, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Text(rank, style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
        ),
        title: Text(route, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
        trailing: Text(trips, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

