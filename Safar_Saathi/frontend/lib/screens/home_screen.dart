import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart'; // Package for animations
import 'validate_trip_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showTripValidationCard = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          children: [
            // Each section now has a subtle entrance animation
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: _buildHeader(),
            ),
            if (_showTripValidationCard)
              // This card now has a more distinct entrance animation
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: _buildNewTripDetectedCard(context),
              ),
            const SizedBox(height: 24),
            // The stat cards now animate in from the sides for a more dynamic feel
            _buildStatCards(),
            const SizedBox(height: 24),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 600),
              child: _buildActivityCard(),
            ),
            const SizedBox(height: 24),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 800),
              child: _buildTodaysTrips(),
            ),
             const SizedBox(height: 24),
             FadeInUp(
              duration: const Duration(milliseconds: 500),
              delay: const Duration(milliseconds: 1000),
              child: _buildImpactCard(),
            ),
             const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // A more personal and modern header section
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good Morning! 👋',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ready to make an impact?',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          // Added a pulse animation to the avatar for a lively touch
          Pulse(
            delay: const Duration(milliseconds: 1200),
            child: const CircleAvatar(
              backgroundImage: NetworkImage('https://placehold.co/100x100/6A1B9A/FFFFFF/png?text=A'),
              radius: 24,
            ),
          )
        ],
      ),
    );
  }
  
  // A redesigned validation card with a gradient background
  Widget _buildNewTripDetectedCard(BuildContext context) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.drive_eta_rounded, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'New Trip Detected!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Car trip • 3.2 km • Ready for validation',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                // The animation is now a very gentle, in-place pulse
                child: Pulse(
                  duration: const Duration(seconds: 2), 
                  delay: const Duration(milliseconds: 400),
                  from: 1.02, // Reduced for a very minimal, gentle pop
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ValidateTripScreen()),
                      );
                      if (result == true) {
                        setState(() {
                          _showTripValidationCard = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text('Validate & Earn 10 Points'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Stat cards now have slide-in animations from the left and right
  Widget _buildStatCards() {
    return Row(
      children: [
        Expanded(
          child: FadeInLeft(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 400),
            child: _buildStatCard(
              icon: Icons.star_rounded,
              value: '1',
              label: 'Total Points',
              color: Colors.orange.shade400,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FadeInRight(
             duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 400),
            child: _buildStatCard(
              icon: Icons.route_rounded,
              value: '23',
              label: 'Trips Logged',
              color: Colors.blue.shade400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({required IconData icon, required String value, required String label, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
  
  // A cleaner activity card with a better progress bar
  Widget _buildActivityCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "This Week's Activity",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '7 trips',
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.7,
                minHeight: 10,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '3 more trips to reach your weekly goal!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
  
  // A modern trip list with styled icons and status tags
  Widget _buildTodaysTrips() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Trips",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _buildTripRow('Kochi → Ernakulam', '9:15 AM', Icons.directions_bus_filled_rounded, true, '+10 pts'),
            const Divider(height: 24, thickness: 0.5),
            _buildTripRow('Office → Lunch', '2:30 PM', Icons.directions_walk_rounded, false, '+5 pts'),
            const SizedBox(height: 16),
            Center(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('View All Trips'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripRow(String title, String time, IconData icon, bool isValidated, String points) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isValidated ? Colors.green.withOpacity(0.15) : Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isValidated ? '✓ Validated' : 'Pending',
                style: TextStyle(
                  color: isValidated ? Colors.green.shade800 : Colors.orange.shade800,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(points, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }
  
  // A beautiful, eye-catching impact card with a green gradient
  Widget _buildImpactCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
           gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.secondary, Colors.green.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Row(
                children: [
                  Icon(Icons.eco_rounded, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Your Impact',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Your data has contributed to 3 transport improvement projects in Kerala.',
                 style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                     Text('₹2.3L', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                     Text('Savings Generated', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                 Column(
                  children: [
                     Text('15%', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                     Text('Traffic Reduced', style: TextStyle(color: Colors.white70)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

