import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'tabs/data_exploration_tab.dart';
import 'tabs/overview_tab.dart';
import 'tabs/reports_tab.dart';
import 'tabs/system_tab.dart';
import '../landing_screen.dart';

// Main widget for the redesigned Planner Dashboard
class PlannerDashboardScreen extends StatelessWidget {
  const PlannerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          automaticallyImplyLeading: false, // Hides the back button
          title: FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Text(
              'Project Atlas Dashboard',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            // User profile section in the AppBar
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Text('NA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('NATPAC', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Admin', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(width: 16),
                  // Exit button
                  TextButton.icon(
                    icon: const Icon(Icons.exit_to_app_rounded),
                    label: const Text('Exit Demo'),
                    onPressed: () {
                       Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LandingScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    style: TextButton.styleFrom(foregroundColor: Colors.grey[600]),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
          // A beautifully styled TabBar
          bottom: TabBar(
            isScrollable: true,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Theme.of(context).colorScheme.primary,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Data Exploration'),
              Tab(text: 'Reports'),
              Tab(text: 'System'),
            ],
          ),
        ),
        // The body now correctly displays the content from the individual tab files
        body: const TabBarView(
          children: [
            OverviewTab(),
            DataExplorationTab(),
            ReportsTab(),
            SystemTab(),
          ],
        ),
      ),
    );
  }
}

