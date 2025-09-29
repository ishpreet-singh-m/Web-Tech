import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned Profile Setup Page
class ProfileSetupPage extends StatefulWidget {
  final ValueChanged<bool>? onProfileSetupComplete; // ✅ callback

  const ProfileSetupPage({super.key, this.onProfileSetupComplete});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  // ✨ --- State Management ---
  // Controller for the name text field
  final _nameController = TextEditingController();
  // Variables to hold the selected dropdown values
  String? _selectedAgeGroup;
  String? _selectedDistrict;
  // Boolean to track if the form is valid to enable the continue button
  bool _isFormValid = false;

  // 🎯 --- Data for Dropdowns ---
  // List of age groups
  final List<String> _ageGroups = [
    'Under 18',
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65+'
  ];

  // List of all districts in Kerala
  final List<String> _keralaDistricts = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Idukki',
    'Ernakulam',
    'Thrissur',
    'Palakkad',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod'
  ];

  // ✨ --- Lifecycle Methods ---
  @override
  void initState() {
    super.initState();
    // Add a listener to the text controller to validate the form on every change
    _nameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _nameController.removeListener(_validateForm);
    _nameController.dispose();
    super.dispose();
  }

  // 🎯 --- Logic ---
  /// Validates the form and updates the state to enable/disable the continue button.
  void _validateForm() {
    setState(() {
      // The form is valid only if all three fields have a value.
      final bool isNameFilled = _nameController.text.trim().isNotEmpty;
      final bool isAgeSelected = _selectedAgeGroup != null;
      final bool isDistrictSelected = _selectedDistrict != null;
      _isFormValid = isNameFilled && isAgeSelected && isDistrictSelected;
    });
  }

  /// Called when the 'Continue' button is pressed.
  void _completeSetup() {
    // You can now access the collected data here, for example:
    // String name = _nameController.text;
    // String ageGroup = _selectedAgeGroup!;
    // String district = _selectedDistrict!;
    //
    // print('Profile Setup Complete:');
    // print('Name: $name, Age: $ageGroup, District: $district');

    // Notify the parent widget (Onboarding_Screen) that setup is complete.
    widget.onProfileSetupComplete?.call(true);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Header graphic and titles remain the same
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: _buildHeaderGraphic(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Personalize Your Experience',
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
            'Help us provide better insights by setting up your profile',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.grey[600]),
          ),
        ),
        const SizedBox(height: 32),

        // ✨ --- Updated Input Fields ---
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: _buildTextField(
            'What should we call you?',
            'Enter your name',
            Icons.person_outline_rounded,
            _nameController, // Pass the controller
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 400),
          child: _buildDropdown(
            'Age Group',
            'Select your age group',
            Icons.cake_outlined,
            _ageGroups, // Pass the list of items
            _selectedAgeGroup, // Pass the current value
            (newValue) {
              setState(() {
                _selectedAgeGroup = newValue;
                _validateForm(); // Validate after selection
              });
            },
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 500),
          child: _buildDropdown(
            'Primary District',
            'Select your district',
            Icons.location_city_outlined,
            _keralaDistricts, // Pass the list of items
            _selectedDistrict, // Pass the current value
            (newValue) {
              setState(() {
                _selectedDistrict = newValue;
                _validateForm(); // Validate after selection
              });
            },
          ),
        ),
        const SizedBox(height: 40), // Increased spacing for the button

        // 🎯 --- New 'Continue' Button ---
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 600),
          child: ElevatedButton(
            // The button's onPressed is null (disabled) if the form is not valid
            onPressed: _isFormValid ? _completeSetup : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
            child: const Text(
              'Continue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildHeaderGraphic(BuildContext context) {
    // ... (This widget remains unchanged)
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Icon(
        Icons.person_add_alt_1_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
    );
  }

  // ✨ Updated to accept a controller
  Widget _buildTextField(
      String label, String hint, IconData icon, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // Use the passed controller
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }

  // ✨ Updated to be fully dynamic
  Widget _buildDropdown(
    String label,
    String hint,
    IconData icon,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: Icon(icon),
          ),
          hint: Text(hint),
          // 🎯 Map the list of strings to a list of DropdownMenuItem widgets
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}