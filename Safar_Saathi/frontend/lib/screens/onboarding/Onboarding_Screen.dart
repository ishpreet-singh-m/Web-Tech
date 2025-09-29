import 'package:flutter/material.dart';
import 'package:SafarSathi/main.dart'; // To navigate to the main app
import 'package:animate_do/animate_do.dart';

// Using relative imports for onboarding pages
import 'pages/all_set_page.dart';
import 'pages/app_tour_page.dart';
import 'pages/how_it_works_page.dart';
import 'pages/notifications_page.dart';
import 'pages/permissions_page.dart';
import 'pages/privacy_consent_page.dart';
import 'pages/profile_setup_page.dart';
import 'pages/welcome_page.dart';

// Main widget for the redesigned Onboarding Screen
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // ✅ Flags to control "Continue" button
  bool _isPrivacyConsentGiven = false;
  bool _isPermissionsGranted = false;
  bool _isProfileSetupComplete = false;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // This list defines the exact order of your onboarding flow.
    _pages = [
      const WelcomePage(),
      const HowItWorksPage(),
      PrivacyConsentPage(
        onConsentChanged: (isComplete) {
          setState(() {
            _isPrivacyConsentGiven = isComplete;
          });
        },
      ),
      PermissionsPage(
        onPermissionsGranted: (granted) {
          setState(() {
            _isPermissionsGranted = granted;
          });
        },
      ),
      ProfileSetupPage(
        onProfileSetupComplete: (done) {
          setState(() {
            _isProfileSetupComplete = done;
          });
        },
      ),
      const NotificationsPage(),
      const AppTourPage(),
      const AllSetPage(),
    ];
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage == _pages.length - 1) {
      _finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // Method to handle the final navigation to the main app
  void _finishOnboarding() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MainNavigator()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopNavBar(),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                physics: const NeverScrollableScrollPhysics(), // disable swipe
                children: _pages,
              ),
            ),
            _buildBottomNavBar(),
          ],
        ),
      ),
    );
  }

  // Top navigation bar with progress indicator + back button
  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? FadeIn(
                  child: IconButton(
                    onPressed: _previousPage,
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                )
              : const SizedBox(width: 48), // placeholder
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(_pages.length, (int index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 8.0,
                width: (index == _currentPage) ? 24.0 : 8.0,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: (index == _currentPage)
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[300],
                ),
              );
            }),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // Shared bottom navigation bar with only "Continue" button
  Widget _buildBottomNavBar() {
    bool isContinueEnabled = true;

    if (_currentPage == 2) {
      isContinueEnabled = _isPrivacyConsentGiven;
    } else if (_currentPage == 3) {
      isContinueEnabled = _isPermissionsGranted;
    } else if (_currentPage == 4) {
      isContinueEnabled = _isProfileSetupComplete;
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: Center(
        child: ElevatedButton(
          onPressed: isContinueEnabled ? _nextPage : null,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 48), // fixed width, centered
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}
