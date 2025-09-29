import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the enhanced Trip History Screen
class TripsScreen extends StatefulWidget {
  const TripsScreen({super.key});

  @override
  State<TripsScreen> createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  // State to keep track of which filter is selected
  int _selectedFilterIndex = 1; // "Pending" is selected by default

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
            'Trip History',
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Statistics cards with slide-in animations
          _buildStatCards(),
          const SizedBox(height: 24),
          // A more polished filter button section
          FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: const Duration(milliseconds: 200),
            child: _buildFilterButtons(),
          ),
          const SizedBox(height: 24),
          // The list of trips, which will animate in
          _buildTripList(),
        ],
      ),
    );
  }

  // Helper method for the animated statistic cards
  Widget _buildStatCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FadeInLeft(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: const StatCard(value: '5', label: 'Total Trips', icon: Icons.route_rounded, color: Colors.blue),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FadeInRight(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: const StatCard(value: '95', label: 'Points Earned', icon: Icons.star_rounded, color: Colors.orange),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
             Expanded(
              child: FadeInLeft(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: const StatCard(value: '91.7', label: 'km Traveled', icon: Icons.map_rounded, color: Colors.purple),
              ),
            ),
             const SizedBox(width: 16),
            Expanded(
              child: FadeInRight(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 400),
                child: const StatCard(value: '20.9', label: 'kg CO₂ Saved', icon: Icons.eco_rounded, color: Colors.green),
              ),
            ),
          ],
        )
      ],
    );
  }

  // A more interactive and visually appealing filter button implementation
  Widget _buildFilterButtons() {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFilterChip(label: 'All Trips', index: 0),
          _buildFilterChip(label: 'Pending', index: 1, hasBadge: true),
          _buildFilterChip(label: 'Validated', index: 2),
        ],
      ),
    );
  }

  Widget _buildFilterChip({required String label, required int index, bool hasBadge = false}) {
    final isSelected = _selectedFilterIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, spreadRadius: 1)]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
              if (hasBadge) ...[
                const SizedBox(width: 6),
                FadeIn(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: const Text('1', style: TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Builds the list of trip cards with a staggered animation effect
  Widget _buildTripList() {
    final List<Trip> allTrips = [
      Trip('Kochi Marine Drive', 'Ernakulam Junction', Icons.directions_car_rounded, 'Today • 2:45 PM • 3.2 km', '+10 pts', TripStatus.pending),
      Trip('Home', 'Office', Icons.directions_bus_rounded, 'Today • 9:15 AM • 8.5 km', '+15 pts', TripStatus.validated),
      Trip('Office', 'Shopping Mall', Icons.directions_walk_rounded, 'Yesterday • 6:30 PM • 1.2 km', '+8 pts', TripStatus.validated),
      Trip('Home', 'Hospital', Icons.local_hospital_rounded, 'Yesterday • 2:20 PM • 4.8 km', '+12 pts', TripStatus.validated),
      Trip('Kochi', 'Thrissur', Icons.train_rounded, 'Oct 15 • 8:00 AM • 74 km', '+50 pts', TripStatus.validated),
    ];

    List<Trip> filteredTrips;
    switch (_selectedFilterIndex) {
      case 1:
        filteredTrips = allTrips.where((trip) => trip.status == TripStatus.pending).toList();
        break;
      case 2:
        filteredTrips = allTrips.where((trip) => trip.status == TripStatus.validated).toList();
        break;
      default:
        filteredTrips = allTrips;
        break;
    }

    if (filteredTrips.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48.0),
          child: Text('No trips in this category.', style: TextStyle(color: Colors.grey, fontSize: 16)),
        ),
      );
    }
    
    return Column(
      // Each trip card animates in one after another
      children: List.generate(filteredTrips.length, (index) {
        return FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: Duration(milliseconds: 100 * index),
          child: TripCard(trip: filteredTrips[index]),
        );
      }),
    );
  }
}

// A redesigned, more visually appealing statistic card
class StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.color = Colors.purple,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
            Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// A redesigned trip card with better visuals
class TripCard extends StatelessWidget {
  final Trip trip;

  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Card(
       margin: const EdgeInsets.only(bottom: 16),
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Icon(trip.icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${trip.from} → ${trip.to}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(trip.details, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStatusChip(trip.status),
                const SizedBox(height: 4),
                Text(trip.points, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // A helper to show a styled chip for the trip status
  Widget _buildStatusChip(TripStatus status) {
    switch (status) {
      case TripStatus.pending:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Pending',
            style: TextStyle(color: Colors.orange.shade800, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
      case TripStatus.validated:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '✓ Validated',
            style: TextStyle(color: Colors.green.shade800, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        );
    }
  }
}

// Enum to represent trip status
enum TripStatus { pending, validated }

// A simple data model for a Trip
class Trip {
  final String from;
  final String to;
  final IconData icon;
  final String details;
  final String points;
  final TripStatus status;

  Trip(this.from, this.to, this.icon, this.details, this.points, this.status);
}

