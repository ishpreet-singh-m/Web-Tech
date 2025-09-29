import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the enhanced Rewards Screen
class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Rewards Hub',
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
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            child: _buildPointsCard(),
          ),
          const SizedBox(height: 24),
          _buildStreakCards(),
          const SizedBox(height: 24),
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 400),
            child: _buildTabs(),
          ),
          const SizedBox(height: 16),
          AnimatedBuilder(
            animation: _tabController,
            builder: (context, child) {
              return _tabController.index == 0
                  ? _buildRewardsList()
                  : _buildBadgesList();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCard() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Available Points',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '1,245',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Contributor', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('Level 3', style: TextStyle(color: Colors.white70)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.6,
                backgroundColor: Colors.white.withOpacity(0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 8),
            const Text('255 points to Champion', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildStreakCards() {
    return Row(
      children: [
        Expanded(
          child: FadeInLeft(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            child: _buildStreakCard('5', 'Day Streak', Icons.local_fire_department_rounded, Colors.redAccent),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FadeInRight(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            child: _buildStreakCard('12', 'Best Streak', Icons.military_tech_rounded, Colors.green),
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(String value, String label, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
                Text(label, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MODIFIED: This widget has been updated with a new color scheme and refined geometry
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TabBar(
        controller: _tabController,
        // The indicator is now the primary theme color with a subtle shadow
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            )
          ],
        ),
        // The selected tab text is now white for better contrast
        labelColor: Colors.white,
        // The unselected tab text uses a softer version of the primary color
        unselectedLabelColor: Theme.of(context).colorScheme.primary.withOpacity(0.8),
        tabs: const [
          Tab(text: 'Rewards'),
          Tab(text: 'Badges'),
        ],
      ),
    );
  }

  Widget _buildRewardsList() {
    final rewards = [
      {'title': 'KSRTC Bus Pass', 'subtitle': '10% discount on monthly bus pass', 'points': '500', 'icon': Icons.directions_bus_rounded, 'isPopular': true, 'isComingSoon': false},
      {'title': 'Kochi Metro Credit', 'subtitle': '₹50 credit for Kochi Metro', 'points': '300', 'icon': Icons.tram_rounded, 'isPopular': false, 'isComingSoon': false},
      {'title': 'Plant a Tree', 'subtitle': 'Plant a tree in your name', 'points': '200', 'icon': Icons.forest_rounded, 'isPopular': false, 'isComingSoon': false},
      {'title': 'Premium Features', 'subtitle': 'Unlock advanced trip analytics', 'points': '800', 'icon': Icons.star_rounded, 'isPopular': false, 'isComingSoon': true},
    ];

    return Column(
      children: List.generate(rewards.length, (index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: _buildRewardItem(
            rewards[index]['title'] as String,
            rewards[index]['subtitle'] as String,
            rewards[index]['points'] as String,
            rewards[index]['icon'] as IconData,
            rewards[index]['isPopular'] as bool,
            rewards[index]['isComingSoon'] as bool,
          ),
        );
      }),
    );
  }

  Widget _buildRewardItem(String title, String subtitle, String points, IconData icon, bool isPopular, bool isComingSoon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (isPopular) _buildTag('Popular', Colors.red),
                      if (isComingSoon) _buildTag('Coming Soon', Colors.blue),
                    ],
                  ),
                  Text(subtitle, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Text(points, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const Text('points', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesList() {
    final badges = [
      {'icon': Icons.celebration_rounded, 'title': 'Early Adopter', 'rarity': 'Common', 'description': 'Joined in the first month', 'isEarned': true, 'progressText': '✓ Earned on Oct 1, 2024', 'progressValue': null},
      {'icon': Icons.local_fire_department_rounded, 'title': 'Week Warrior', 'rarity': 'Common', 'description': 'Log trips for 7 consecutive days', 'isEarned': true, 'progressText': '✓ Earned on Oct 8, 2024', 'progressValue': null},
      {'icon': Icons.eco_rounded, 'title': 'Eco Champion', 'rarity': 'Rare', 'description': 'Save 50kg of CO₂ emissions', 'isEarned': true, 'progressText': '✓ Earned on Oct 12, 2024', 'progressValue': null},
      {'icon': Icons.directions_bus_rounded, 'title': 'Bus Buddy', 'rarity': 'Common', 'description': 'Take 25 bus trips', 'isEarned': false, 'progressText': '18/25', 'progressValue': 18 / 25},
      {'icon': Icons.search_rounded, 'title': 'Data Detective', 'rarity': 'Rare', 'description': 'Validate 100 trips', 'isEarned': false, 'progressText': '67/100', 'progressValue': 67 / 100},
      {'icon': Icons.directions_run_rounded, 'title': 'Distance Master', 'rarity': 'Epic', 'description': 'Travel 1000km total', 'isEarned': false, 'progressText': '743/1000', 'progressValue': 743 / 1000},
    ];

    return Column(
      children: List.generate(badges.length, (index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: _buildBadgeItem(
             badges[index]['icon'] as IconData,
             badges[index]['title'] as String,
             badges[index]['rarity'] as String,
             badges[index]['description'] as String,
             badges[index]['isEarned'] as bool,
             badges[index]['progressText'] as String,
             badges[index]['progressValue'] as double?,
          ),
        );
      }),
    );
  }

  Widget _buildBadgeItem(IconData icon, String title, String rarity, String description, bool isEarned, String progressText, double? progressValue) {
    final color = _getRarityColor(rarity);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.1),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                          _buildTag(rarity, color),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isEarned ? progressText : description,
                        style: TextStyle(color: isEarned ? Colors.green.shade700 : Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!isEarned && progressValue != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressValue,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(progressText, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Color _getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'rare':
        return Colors.purple;
      case 'epic':
        return Colors.red;
      case 'common':
      default:
        return Colors.blueGrey;
    }
  }
}

