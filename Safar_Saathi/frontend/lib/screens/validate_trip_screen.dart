import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'validate_trip_screen.dart'; // Correctly import the confirmation screen

// Main widget for the enhanced Validate Trip Screen
class ValidateTripScreen extends StatefulWidget {
  const ValidateTripScreen({super.key});

  @override
  State<ValidateTripScreen> createState() => _ValidateTripScreenState();
}

class _ValidateTripScreenState extends State<ValidateTripScreen> {
  String _selectedMode = 'Car';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: Text(
          'Validate Trip',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Each section now animates into view for a smooth experience
          FadeInUp(child: _buildMapPlaceholder()),
          const SizedBox(height: 24),
          FadeInUp(delay: const Duration(milliseconds: 100), child: _buildTripDetailsCard()),
          const SizedBox(height: 24),
          FadeInUp(delay: const Duration(milliseconds: 200), child: _buildTravelModeSection()),
          const SizedBox(height: 24),
          FadeInUp(delay: const Duration(milliseconds: 300), child: _buildAddDetailsCard()),
          const SizedBox(height: 32),
          FadeInUp(delay: const Duration(milliseconds: 400), child: _buildActionButtons()),
        ],
      ),
    );
  }

  // A more visually engaging map placeholder
  Widget _buildMapPlaceholder() {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias, // Ensures the gradient respects the border radius
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[800]!, Colors.grey[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.greenAccent, size: 50),
              SizedBox(height: 8),
              Text('Via MG Road', style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  // A cleaner, more readable trip details card
  Widget _buildTripDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Trip Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '+10 points',
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                )
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow('From:', 'Kochi Marine Drive'),
            _buildDetailRow('To:', 'Ernakulam Junction'),
            _buildDetailRow('Time:', '2:45 PM - 3:12 PM'),
            _buildDetailRow('Duration:', '27 minutes'),
            _buildDetailRow('Distance:', '3.2 km'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Redesigned travel mode selection with better visuals and animations
  Widget _buildTravelModeSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('How did you travel?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Our AI thinks you traveled by Car. Is this correct?', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
              children: [
                _buildTravelModeChip('Car', Icons.directions_car_rounded, '92% confident', isSuggested: true),
                _buildTravelModeChip('Bus', Icons.directions_bus_rounded, null),
                _buildTravelModeChip('Bike', Icons.two_wheeler_rounded, null),
                _buildTravelModeChip('Walk', Icons.directions_walk_rounded, null),
                _buildTravelModeChip('Auto', Icons.local_taxi_rounded, null),
                _buildTravelModeChip('Metro', Icons.tram_rounded, null),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelModeChip(String mode, IconData icon, String? confidence, {bool isSuggested = false}) {
    final isSelected = _selectedMode == mode;
    final color = isSuggested ? Colors.redAccent : Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(mode, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (confidence != null) ...[
              const SizedBox(height: 2),
              Text(confidence, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildAddDetailsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add more details', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Optional - Help us understand your trip better', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            OutlinedButton(onPressed: () {}, child: const Text('Add Details')),
          ],
        ),
      ),
    );
  }

  // A dedicated section for the main action buttons
  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () async {
            // CORRECTED NAVIGATION: This now correctly navigates to the TripValidatedScreen
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ValidateTripScreen()),
            );

            // If validation was successful, pop back to the home screen
            if (result == true && mounted) {
              Navigator.pop(context, true);
            }
          },
          style: ElevatedButton.styleFrom(
             padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('✓ Confirm $_selectedMode Trip (10 points)'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Skip for now', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

