import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToOnboarding();
  }

  Future<void> _goToOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/bike.png',
              width: 120,
              height: 120,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback in case the asset path is wrong
                return Icon(
                  Icons.pedal_bike_rounded,
                  size: 80,
                  color: AppColors.primary,
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'PedalCast',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Predict. Plan. Ride.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}