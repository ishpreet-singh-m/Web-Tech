import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:permission_handler/permission_handler.dart'; // 🎯 Import the package

// Main widget for the redesigned Permissions Page
class PermissionsPage extends StatefulWidget {
  final ValueChanged<bool>? onPermissionsGranted; // ✅ callback

  const PermissionsPage({super.key, this.onPermissionsGranted});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  // ✨ --- State Management for Permissions ---
  // Track the status of each permission individually.
  PermissionStatus _locationStatus = PermissionStatus.denied;
  PermissionStatus _motionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    // Check the current status of permissions when the page loads.
    _checkInitialPermissions();
  }

  // 🎯 --- Permission Logic ---

  /// Checks the initial status of permissions and updates the UI.
  Future<void> _checkInitialPermissions() async {
    final location = await Permission.location.status;
    final motion = await Permission.activityRecognition.status;
    setState(() {
      _locationStatus = location;
      _motionStatus = motion;
    });
    _notifyParentIfAllGranted();
  }

  /// Requests permissions from the user.
  Future<void> _requestPermissions() async {
    // Request both permissions. The user will see separate popups.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.activityRecognition,
    ].request();

    // Update the state with the new statuses
    setState(() {
      _locationStatus = statuses[Permission.location] ?? _locationStatus;
      _motionStatus =
          statuses[Permission.activityRecognition] ?? _motionStatus;
    });
    _notifyParentIfAllGranted();
  }

  /// Checks if all required permissions are granted and notifies the parent widget.
  void _notifyParentIfAllGranted() {
    final allGranted =
        _locationStatus.isGranted && _motionStatus.isGranted;
    widget.onPermissionsGranted?.call(allGranted);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: _buildHeaderGraphic(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Permissions Required',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 200),
          child: Text(
            'To provide the best experience, we need a couple of permissions.',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 32),

        // ✨ --- Dynamic Permission Items ---
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: _buildPermissionItem(
            context,
            icon: Icons.location_on_rounded,
            title: 'Location Access',
            subtitle: 'To detect trips and routes',
            status: _locationStatus, // Pass the real status
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 400),
          child: _buildPermissionItem(
            context,
            icon: Icons.directions_run_rounded,
            title: 'Motion & Fitness',
            subtitle: 'To detect transport mode',
            status: _motionStatus, // Pass the real status
          ),
        ),
        const SizedBox(height: 40),

        // 🎯 --- "Grant Permissions" Button ---
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 600),
          child: ElevatedButton(
            // The button is only needed if not all permissions are already granted.
            onPressed: (_locationStatus.isGranted && _motionStatus.isGranted)
                ? null // Disable if all granted
                : _requestPermissions,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text(
              'Grant Permissions',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderGraphic(BuildContext context) {
    // ... (This widget remains unchanged)
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Icon(
        Icons.shield_outlined,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
    );
  }

  // ✨ Updated to show dynamic status
  Widget _buildPermissionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required PermissionStatus status,
  }) {
    return Card(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        leading: CircleAvatar(
          backgroundColor:
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).colorScheme.secondary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: _buildStatusChip(status), // Use a helper for the chip
      ),
    );
  }

  // 🎯 Helper widget to create a status chip based on PermissionStatus
  Widget _buildStatusChip(PermissionStatus status) {
    String text;
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case PermissionStatus.granted:
        text = 'Granted';
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green.shade800;
        break;
      case PermissionStatus.denied:
        text = 'Required';
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red.shade800;
        break;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        text = 'Denied';
        backgroundColor = Colors.orange.withOpacity(0.1);
        textColor = Colors.orange.shade800;
        break;
      default:
        text = 'Unknown';
        backgroundColor = Colors.grey.withOpacity(0.1);
        textColor = Colors.grey.shade800;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}