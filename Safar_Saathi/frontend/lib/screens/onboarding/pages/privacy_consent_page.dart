import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

// Main widget for the redesigned Privacy & Consent Page
class PrivacyConsentPage extends StatefulWidget {
  // This callback is crucial for disabling the 'Continue' button in the parent widget.
  final Function(bool) onConsentChanged;

  const PrivacyConsentPage({super.key, required this.onConsentChanged});

  @override
  State<PrivacyConsentPage> createState() => _PrivacyConsentPageState();
}

class _PrivacyConsentPageState extends State<PrivacyConsentPage> {
  // State variables for each checkbox
  bool _consent1 = false;
  bool _consent2 = false;
  bool _consent3 = false;

  // A helper method to check if all consents are given and notify the parent
  void _updateConsentStatus() {
    final bool allConsented = _consent1 && _consent2 && _consent3;
    widget.onConsentChanged(allConsented);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        // Each section now animates into view for a smooth experience
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: _buildHeaderGraphic(context),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: Text(
            'Privacy & Consent',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 32),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 200),
          child: _buildInfoCard(
            context: context,
            title: 'What data do we collect?',
            items: [
              'Your location during trips (encrypted)',
              'Travel mode (car, bus, walk, etc.)',
              'Trip start and end times',
            ],
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 300),
          child: _buildInfoCard(
            context: context,
            title: 'Privacy Guarantees',
            items: [
              'All data is anonymized before analysis',
              'No personal identifiers are stored',
              'You can delete your data anytime',
            ],
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 24),
        // The checkboxes now have a staggered animation
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 400),
          child: _buildCheckbox('I consent to the collection of my travel data.', _consent1, (val) => setState(() { _consent1 = val!; _updateConsentStatus(); })),
        ),
        FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 500),
          child: _buildCheckbox('I allow location tracking for accurate collection.', _consent2, (val) => setState(() { _consent2 = val!; _updateConsentStatus(); })),
        ),
         FadeInUp(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 600),
          child: _buildCheckbox('I understand my data will be used for research.', _consent3, (val) => setState(() { _consent3 = val!; _updateConsentStatus(); })),
        ),
      ],
    );
  }

  // A more visually engaging header graphic
  Widget _buildHeaderGraphic(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Icon(
        Icons.privacy_tip_rounded,
        color: Theme.of(context).colorScheme.primary,
        size: 60,
      ),
    );
  }

  // A redesigned info card for a cleaner, more modern look
  Widget _buildInfoCard({required BuildContext context, required String title, required List<String> items, required Color color}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
            const Divider(height: 24),
            ...items.map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 20, color: color),
                      const SizedBox(width: 12),
                      Expanded(child: Text(item)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // A redesigned checkbox for better visual consistency
  Widget _buildCheckbox(String title, bool value, ValueChanged<bool?> onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: CheckboxListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

