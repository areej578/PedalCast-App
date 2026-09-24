import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';

class _OnboardingData {
  final String lottieAsset;
  final String title;
  final String description;

  const _OnboardingData({
    required this.lottieAsset,
    required this.title,
    required this.description,
  });
}

const List<_OnboardingData> _pages = [
  _OnboardingData(
    lottieAsset: 'assets/lottie/onboarding_1.json',
    title: 'Know Your City\'s Bike Demand',
    description:
        'PedalCast uses weather and time patterns to predict how many bikes will be rented — before it happens.',
  ),
  _OnboardingData(
    lottieAsset: 'assets/lottie/onboarding_2.json',
    title: 'Enter Weather & Time',
    description:
        'Just tell us the season, weather, and hour — the same conditions a rider would experience.',
  ),
  _OnboardingData(
    lottieAsset: 'assets/lottie/onboarding_4.json',
    title: 'Get Instant Predictions',
    description:
        'Our model instantly estimates expected rental demand, so planning ahead becomes easy.',
  ),
  _OnboardingData(
    lottieAsset: 'assets/lottie/onboarding_3.json',
    title: 'Track & Plan Ahead',
    description:
        'Visualize demand trends across hours and seasons to make smarter decisions every day.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _goToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  void _onNextPressed() {
    if (_currentPage == _pages.length - 1) {
      _goToHome();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Opacity(
                  opacity: isLastPage ? 0 : 1,
                  child: TextButton(
                    onPressed: isLastPage ? null : _goToHome,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Swipeable pages
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 240,
                          height: 240,
                          child: Lottie.asset(
                            page.lottieAsset,
                            fit: BoxFit.contain,
                            repeat: true,
                            animate: true,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback if the Lottie file fails to load
                              return Icon(
                                Icons.image_not_supported_outlined,
                                size: 70,
                                color: AppColors.primary,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: _onNextPressed,
                child: Text(isLastPage ? 'Get Started' : 'Next'),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}